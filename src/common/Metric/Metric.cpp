/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license, you may redistribute it and/or modify it under version 3 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#include "Metric.h"
#include "Common.h"
#include "Config.h"
#include "Log.h"
#include "Strand.h"
#include "Util.h"
#include <boost/algorithm/string/replace.hpp>
#include <boost/asio/deadline_timer.hpp>
#include <boost/asio/ip/tcp.hpp>

void Metric::Initialize(std::string const& realmName, acore::Asio::IoContext& ioContext, std::function<void()> overallStatusLogger)
{
    _dataStream = std::make_unique<boost::asio::ip::tcp::iostream>();
    _realmName = FormatInfluxDBTagValue(realmName);
    _batchTimer = std::make_unique<boost::asio::deadline_timer>(ioContext);
    _overallStatusTimer = std::make_unique<boost::asio::deadline_timer>(ioContext);
    _overallStatusLogger = overallStatusLogger;
    LoadFromConfigs();
}

bool Metric::Connect()
{
    auto& stream = static_cast<boost::asio::ip::tcp::iostream&>(GetDataStream());
    stream.connect(_hostname, _port);
    auto error = stream.error();
    if (error)
    {
        LOG_ERROR("metric", "Error connecting to '%s:%s', disabling Metric. Error message : %s",
            _hostname.c_str(), _port.c_str(), error.message().c_str());
        _enabled = false;
        return false;
    }
    stream.clear();
    return true;
}

void Metric::LoadFromConfigs()
{
    bool previousValue = _enabled;
    _enabled = sConfigMgr->GetBoolDefault("Metric.Enable", false);
    _updateInterval = sConfigMgr->GetIntDefault("Metric.Interval", 10);
    if (_updateInterval < 1)
    {
        LOG_ERROR("metric", "'Metric.Interval' config set to %d, overriding to 1.", _updateInterval);
        _updateInterval = 1;
    }

    _overallStatusTimerInterval = sConfigMgr->GetIntDefault("Metric.OverallStatusInterval", 1);
    if (_overallStatusTimerInterval < 1)
    {
        LOG_ERROR("metric", "'Metric.OverallStatusInterval' config set to %d, overriding to 1.", _overallStatusTimerInterval);
        _overallStatusTimerInterval = 1;
    }

    _thresholds.clear();
    std::vector<std::string> thresholdSettings = sConfigMgr->GetKeysByString("Metric.Threshold.");
    for (std::string const& thresholdSetting : thresholdSettings)
    {
        int thresholdValue = sConfigMgr->GetIntDefault(thresholdSetting, 0);
        std::string thresholdName = thresholdSetting.substr(strlen("Metric.Threshold."));
        _thresholds[thresholdName] = thresholdValue;
    }

    // Schedule a send at this point only if the config changed from Disabled to Enabled.
    // Cancel any scheduled operation if the config changed from Enabled to Disabled.
    if (_enabled && !previousValue)
    {
        std::string connectionInfo = sConfigMgr->GetStringDefault("Metric.ConnectionInfo", "");
        if (connectionInfo.empty())
        {
            LOG_ERROR("metric", "'Metric.ConnectionInfo' not specified in configuration file.");
            return;
        }

        std::vector<std::string_view> tokens = acore::Tokenize(connectionInfo, ';', true);
        if (tokens.size() != 3)
        {
            LOG_ERROR("metric", "'Metric.ConnectionInfo' specified with wrong format in configuration file.");
            return;
        }

        _hostname.assign(tokens[0]);
        _port.assign(tokens[1]);
        _databaseName.assign(tokens[2]);
        Connect();

        ScheduleSend();
        ScheduleOverallStatusLog();
    }
}

void Metric::Update()
{
    if (_overallStatusTimerTriggered)
    {
        _overallStatusTimerTriggered = false;
        _overallStatusLogger();
    }
}

bool Metric::ShouldLog(std::string const& category, int64 value) const
{
    auto threshold = _thresholds.find(category);
    if (threshold == _thresholds.end())
        return false;
    return value >= threshold->second;
}


void Metric::LogEvent(std::string const& category, std::string const& title, std::string const& description)
{
    using namespace std::chrono;

    MetricData* data = new MetricData;
    data->Category = category;
    data->Timestamp = system_clock::now();
    data->Type = AC_METRIC_DATA_EVENT;
    data->Title = title;
    data->Text = description;

    _queuedData.Enqueue(data);
}

void Metric::SendBatch()
{
    using namespace std::chrono;

    std::stringstream batchedData;
    MetricData* data;
    bool firstLoop = true;
    while (_queuedData.Dequeue(data))
    {
        if (!firstLoop)
            batchedData << "\n";

        batchedData << data->Category;
        if (!_realmName.empty())
            batchedData << ",realm=" << _realmName;

        for (MetricTag const& tag : data->Tags)
            batchedData << "," << tag.first << "=" << FormatInfluxDBTagValue(tag.second);

        batchedData << " ";

        switch (data->Type)
        {
            case AC_METRIC_DATA_VALUE:
                batchedData << "value=" << data->Value;
                break;
            case AC_METRIC_DATA_EVENT:
                batchedData << "title=\"" << data->Title << "\",text=\"" << data->Text << "\"";
                break;
        }

        batchedData << " ";

        batchedData << std::to_string(duration_cast<nanoseconds>(data->Timestamp.time_since_epoch()).count());

        firstLoop = false;
        delete data;
    }

    // Check if there's any data to send
    if (batchedData.tellp() == std::streampos(0))
    {
        ScheduleSend();
        return;
    }

    if (!GetDataStream().good() && !Connect())
        return;

    GetDataStream() << "POST " << "/write?db=" << _databaseName << " HTTP/1.1\r\n";
    GetDataStream() << "Host: " << _hostname << ":" << _port << "\r\n";
    GetDataStream() << "Accept: */*\r\n";
    GetDataStream() << "Content-Type: application/octet-stream\r\n";
    GetDataStream() << "Content-Transfer-Encoding: binary\r\n";

    GetDataStream() << "Content-Length: " << std::to_string(batchedData.tellp()) << "\r\n\r\n";
    GetDataStream() << batchedData.rdbuf();

    std::string http_version;
    GetDataStream() >> http_version;
    unsigned int status_code = 0;
    GetDataStream() >> status_code;
    if (status_code != 204)
    {
        LOG_ERROR("metric", "Error sending data, returned HTTP code: %u", status_code);
    }

    // Read and ignore the status description
    std::string status_description;
    std::getline(GetDataStream(), status_description);
    // Read headers
    std::string header;
    while (std::getline(GetDataStream(), header) && header != "\r")
    {
        if (header == "Connection: close\r")
            static_cast<boost::asio::ip::tcp::iostream&>(GetDataStream()).close();
    }

    ScheduleSend();
}

void Metric::ScheduleSend()
{
    if (_enabled)
    {
        _batchTimer->expires_from_now(boost::posix_time::seconds(_updateInterval));
        _batchTimer->async_wait(std::bind(&Metric::SendBatch, this));
    }
    else
    {
        static_cast<boost::asio::ip::tcp::iostream&>(GetDataStream()).close();
        MetricData* data;
        // Clear the queue
        while (_queuedData.Dequeue(data))
            delete data;;
    }
}

void Metric::Unload()
{
    // Send what's queued only if io_service is stopped (so only on shutdown)
    if (_enabled && acore::Asio::get_io_context(*_batchTimer).stopped())
    {
        _enabled = false;
        SendBatch();
    }

    _batchTimer->cancel();
    _overallStatusTimer->cancel();
}

void Metric::ScheduleOverallStatusLog()
{
    if (_enabled)
    {
        _overallStatusTimer->expires_from_now(boost::posix_time::seconds(_overallStatusTimerInterval));
        _overallStatusTimer->async_wait([this](const boost::system::error_code&)
        {
            _overallStatusTimerTriggered = true;
            ScheduleOverallStatusLog();
        });
    }
}

std::string Metric::FormatInfluxDBValue(bool value)
{
    return value ? "t" : "f";
}

template<class T>
std::string Metric::FormatInfluxDBValue(T value)
{
    return std::to_string(value) + 'i';
}

std::string Metric::FormatInfluxDBValue(std::string const& value)
{
    return '"' + boost::replace_all_copy(value, "\"", "\\\"") + '"';
}

std::string Metric::FormatInfluxDBValue(char const* value)
{
    return FormatInfluxDBValue(std::string(value));
}

std::string Metric::FormatInfluxDBValue(double value)
{
    return std::to_string(value);
}

std::string Metric::FormatInfluxDBValue(float value)
{
    return FormatInfluxDBValue(double(value));
}

std::string Metric::FormatInfluxDBTagValue(std::string const& value)
{
    // ToDo: should handle '=' and ',' characters too
    return boost::replace_all_copy(value, " ", "\\ ");
}

std::string Metric::FormatInfluxDBValue(std::chrono::nanoseconds value)
{
    return FormatInfluxDBValue(std::chrono::duration_cast<Milliseconds>(value).count());
}

Metric::Metric()
{
}

Metric::~Metric()
{
}

Metric* Metric::instance()
{
    static Metric instance;
    return &instance;
}

template std::string Metric::FormatInfluxDBValue(int8);
template std::string Metric::FormatInfluxDBValue(uint8);
template std::string Metric::FormatInfluxDBValue(int16);
template std::string Metric::FormatInfluxDBValue(uint16);
template std::string Metric::FormatInfluxDBValue(int32);
template std::string Metric::FormatInfluxDBValue(uint32);
template std::string Metric::FormatInfluxDBValue(int64);
template std::string Metric::FormatInfluxDBValue(uint64);
