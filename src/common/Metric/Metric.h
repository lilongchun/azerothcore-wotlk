/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license, you may redistribute it and/or modify it under version 3 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef AC_METRIC_H__
#define AC_METRIC_H__

#include "Define.h"
#include "Duration.h"
#include "MPSCQueue.h"
#include <chrono>
#include <functional>
#include <iosfwd>
#include <memory>
#include <string>
#include <unordered_map>
#include <vector>
#include <utility>


namespace acore
{
    namespace Asio
    {
        class IoContext;
    }
}

enum MetricDataType
{
    AC_METRIC_DATA_VALUE,
    AC_METRIC_DATA_EVENT
};

typedef std::pair<std::string, std::string> MetricTag;

struct MetricData
{
    std::string Category;
    SystemTimePoint Timestamp;
    MetricDataType Type;
    std::vector<MetricTag> Tags;

    // LogValue-specific fields
    std::string Value;

    // LogEvent-specific fields
    std::string Title;
    std::string Text;
};

class /*AC_COMMON_API*/ Metric
{
private:
    std::iostream& GetDataStream() { return *_dataStream; }
    std::unique_ptr<std::iostream> _dataStream;    MPSCQueue<MetricData> _queuedData;
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
    std::unordered_map<std::string, int64> _thresholds;

    bool Connect();
    void SendBatch();
    void ScheduleSend();
    void ScheduleOverallStatusLog();

    static std::string FormatInfluxDBValue(bool value);
    template <class T>
    static std::string FormatInfluxDBValue(T value);
    static std::string FormatInfluxDBValue(std::string const& value);
    static std::string FormatInfluxDBValue(char const* value);
    static std::string FormatInfluxDBValue(double value);
    static std::string FormatInfluxDBValue(float value);
    static std::string FormatInfluxDBValue(std::chrono::nanoseconds value);

    static std::string FormatInfluxDBValue(std::string const& value)
    {
        return '"' + boost::replace_all_copy(value, "\"", "\\\"") + '"';
    }

    static std::string FormatInfluxDBTagValue(std::string const& value);

    // ToDo: should format TagKey and FieldKey too in the same way as TagValue

public:
    Metric();
    ~Metric();
    static Metric* instance();

    void Initialize(std::string const& realmName, acore::Asio::IoContext& ioContext, std::function<void()> overallStatusLogger);
    void LoadFromConfigs();
    void Update();
    bool ShouldLog(std::string const& category, int64 value) const;

    template<class T>
    void LogValue(std::string const& category, T value, std::vector<MetricTag> tags)
    {
        using namespace std::chrono;

        MetricData* data = new MetricData;
        data->Category = category;
        data->Timestamp = system_clock::now();
        data->Type = AC_METRIC_DATA_VALUE;
        data->Value = FormatInfluxDBValue(value);
        data->Tags = std::move(tags);

        _queuedData.Enqueue(data);
    }

    void LogEvent(std::string const& category, std::string const& title, std::string const& description);

    void Unload();
    bool IsEnabled() const { return _enabled; }
};

#define sMetric Metric::instance()

template<typename LoggerType>
class MetricStopWatch
{
public:
    MetricStopWatch(LoggerType&& loggerFunc) :
        _logger(std::forward<LoggerType>(loggerFunc)),
        _startTime(sMetric->IsEnabled() ? std::chrono::steady_clock::now() : TimePoint())
    {
    }

    ~MetricStopWatch()
    {
        if (sMetric->IsEnabled())
            _logger(_startTime);
    }

private:
    LoggerType _logger;
    TimePoint _startTime;
};

template<typename LoggerType>
MetricStopWatch<LoggerType> MakeMetricStopWatch(LoggerType&& loggerFunc)
{
    return { std::forward<LoggerType>(loggerFunc) };
}

#define TC_AC_METRIC_TAG(name, value) { name, value }

#define AC_METRIC_DO_CONCAT(a, b) a##b
#define AC_METRIC_CONCAT(a, b) TC_AC_METRIC_DO_CONCAT(a, b)
#define AC_METRIC_UNIQUE_NAME(name) AC_METRIC_CONCAT(name, __LINE__)

#if defined PERFORMANCE_PROFILING || defined WITHOUT_METRICS
#define AC_METRIC_EVENT(category, title, description) ((void)0)
#define AC_METRIC_VALUE(category, value) ((void)0)
#define AC_METRIC_TIMER(category, ...) ((void)0)
#else
#  if AC_PLATFORM != AC_PLATFORM_WINDOWS
#define AC_METRIC_EVENT(category, title, description)                      \
        do {                                                            \
            if (sMetric->IsEnabled())                                   \
                sMetric->LogEvent(category, title, description);        \
        } while (0)
#define AC_METRIC_VALUE(category, value, ...)                              \
        do {                                                            \
            if (sMetric->IsEnabled())                                   \
                sMetric->LogValue(category, value, { __VA_ARGS__ }););  \
        } while (0)
# else
#define AC_METRIC_EVENT(category, title, description)                      \
        __pragma(warning(push))                                         \
        __pragma(warning(disable:4127))                                 \
        do {                                                            \
            if (sMetric->IsEnabled())                                   \
                sMetric->LogEvent(category, title, description);        \
        } while (0)                                                     \
        __pragma(warning(pop))
#define AC_METRIC_VALUE(category, value, ...)                              \
        __pragma(warning(push))                                         \
        __pragma(warning(disable:4127))                                 \
        do {                                                            \
            if (sMetric->IsEnabled())                                   \
                sMetric->LogValue(category, value, { __VA_ARGS__ }););  \
        } while (0)                                                     \
        __pragma(warning(pop))
#  endif
#define AC_METRIC_TIMER(category, ...)                                                                             \
        MetricStopWatch AC_METRIC_UNIQUE_NAME(__AC_METRIC_stop_watch) = MakeMetricStopWatch([&](TimePoint start)   \
        {                                                                                                       \
            sMetric->LogValue(category, std::chrono::steady_clock::now() - start, { __VA_ARGS__ });             \
        });
#  if defined WITH_DETAILED_METRICS
#define AC_METRIC_DETAILED_TIMER(category, ...)                                                                 \
        MetricStopWatch AC_METRIC_UNIQUE_NAME(__AC_METRIC_stop_watch) = MakeMetricStopWatch([&](TimePoint start)   \
        {                                                                                                       \
            int64 duration = int64(std::chrono::duration_cast<Milliseconds>(std::chrono::steady_clock::now() - start).count()); \
            if (sMetric->ShouldLog(category, duration))                                                          \
                sMetric->LogValue(category, duration, { __VA_ARGS__ });                                          \
        });
#  else
#define AC_METRIC_DETAILED_TIMER(category, ...) ((void)0)
#  endif

#endif

#endif // AC_METRIC_H__
