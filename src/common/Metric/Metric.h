/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license, you may redistribute it and/or modify it under version 3 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef METRIC_H__
#define METRIC_H__

#include "Common.h"
#include "Threading/PCQueue.h"
#include <boost/asio/ip/tcp.hpp>
#include <boost/algorithm/string.hpp>
#include <type_traits>

enum MetricDataType
{
    METRIC_DATA_VALUE,
    METRIC_DATA_EVENT
};

struct MetricData
{
    std::string Category;
    std::chrono::time_point<std::chrono::system_clock> Timestamp;
    MetricDataType Type;

    // LogValue-specific fields
    std::string Value;

    // LogEvent-specific fields
    std::string Title;
    std::string Text;
};

class /*AC_COMMON_API*/ Metric
{
private:
    boost::asio::ip::tcp::iostream _dataStream;
    MPSCQueue<MetricData> _queuedData;
    std::unique_ptr<boost::asio::deadline_timer> _batchTimer;
    std::unique_ptr<boost::asio::deadline_timer> _overallStatusTimer;
    int32 _updateInterval = 0;
    int32 _overallStatusTimerInterval = 0;
    bool _enabled = false;
    bool _overallStatusTimerTriggered = false;
    std::string _hostname;
    std::string _port;
    std::string _databaseName;
    std::function<void()> _overallStatusLogger;
    std::string _realmName;

    bool Connect();
    void SendBatch();
    void ScheduleSend();
    void ScheduleOverallStatusLog();

    template<class T, typename std::enable_if<std::is_integral<T>::value>::type* = nullptr>
    static std::string FormatInfluxDBValue(T value) { return std::to_string(value) + 'i'; }

    static std::string FormatInfluxDBValue(std::string const& value)
    {
        return '"' + boost::replace_all_copy(value, "\"", "\\\"") + '"';
    }

    static std::string FormatInfluxDBValue(bool value) { return value ? "t" : "f"; }
    static std::string FormatInfluxDBValue(const char* value) { return FormatInfluxDBValue(std::string(value)); }
    static std::string FormatInfluxDBValue(double value) { return std::to_string(value); }
    static std::string FormatInfluxDBValue(float value) { return FormatInfluxDBValue(double(value)); }

public:
    static Metric* instance();

    void Initialize(std::string const& realmName, boost::asio::io_service& ioService, std::function<void()> overallStatusLogger = [](){});
    void LoadFromConfigs();
    void Update();

    template<class T>
    void LogValue(std::string const& category, T value)
    {
        using namespace std::chrono;

        MetricData* data = new MetricData;
        data->Category = category;
        data->Timestamp = system_clock::now();
        data->Type = METRIC_DATA_VALUE;
        data->Value = FormatInfluxDBValue(value);

        _queuedData.Enqueue(data);
    }

    void LogEvent(std::string const& category, std::string const& title, std::string const& description);

    void ForceSend();
    bool IsEnabled() const { return _enabled; }
};

#define sMetric Metric::instance()

#if PLATFORM != PLATFORM_WINDOWS
#define METRIC_EVENT(category, title, description)                    \
        do {                                                            \
            if (sMetric->IsEnabled())                              \
                sMetric->LogEvent(category, title, description);   \
        } while (0)
#define METRIC_VALUE(category, value)                                 \
        do {                                                            \
            if (sMetric->IsEnabled())                              \
                sMetric->LogValue(category, value);                \
        } while (0)
#else
#define METRIC_EVENT(category, title, description)                    \
        __pragma(warning(push))                                         \
        __pragma(warning(disable:4127))                                 \
        do {                                                            \
            if (sMetric->IsEnabled())                              \
                sMetric->LogEvent(category, title, description);   \
        } while (0)                                                     \
        __pragma(warning(pop))
#define METRIC_VALUE(category, value)                                 \
        __pragma(warning(push))                                         \
        __pragma(warning(disable:4127))                                 \
        do {                                                            \
            if (sMetric->IsEnabled())                              \
                sMetric->LogValue(category, value);                \
        } while (0)                                                     \
        __pragma(warning(pop))
#endif

#endif // METRIC_H__
