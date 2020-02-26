/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#include "Util.h"
#include "Common.h"
#include "utf8.h"
#include "Log.h"
#include "DatabaseWorker.h"
#include "SQLOperation.h"
#include "Errors.h"
#include "TypeList.h"
#include "SFMT.h"
#include "Errors.h" // for ASSERT
#include <ace/TSS_T.h>
#include <array>
#include <cwchar>
#include <string>
#include <random>

typedef ACE_TSS<SFMTRand> SFMTRandTSS;
static SFMTRandTSS sfmtRand;
static SFMTEngine engine;

int32 irand(int32 min, int32 max)
{
    ASSERT(max >= min);
    return int32(sfmtRand->IRandom(min, max));
}

uint32 urand(uint32 min, uint32 max)
{
    ASSERT(max >= min);
    return sfmtRand->URandom(min, max);
}

float frand(float min, float max)
{
    ASSERT(max >= min);
    return float(sfmtRand->Random() * (max - min) + min);
}

uint32 rand32()
{
    return int32(sfmtRand->BRandom());
}

double rand_norm()
{
    return sfmtRand->Random();
}

double rand_chance()
{
    return sfmtRand->Random() * 100.0;
}

uint32 urandweighted(size_t count, double const* chances)
{
    std::discrete_distribution<uint32> dd(chances, chances + count);
    return dd(SFMTEngine::Instance());
}

SFMTEngine& SFMTEngine::Instance()
{
    return engine;
}

Tokenizer::Tokenizer(const std::string &src, const char sep, uint32 vectorReserve)
{
    m_str = new char[src.length() + 1];
    memcpy(m_str, src.c_str(), src.length() + 1);

    if (vectorReserve)
        m_storage.reserve(vectorReserve);

    char* posold = m_str;
    char* posnew = m_str;

    for (;;)
    {
        if (*posnew == sep)
        {
            m_storage.push_back(posold);
            posold = posnew + 1;

            *posnew = '\0';
        }
        else if (*posnew == '\0')
        {
            // Hack like, but the old code accepted these kind of broken strings,
            // so changing it would break other things
            if (posold != posnew)
                m_storage.push_back(posold);

            break;
        }

        ++posnew;
    }
}

void stripLineInvisibleChars(std::string &str)
{
    static std::string const invChars = " \t\7\n";

    size_t wpos = 0;

    bool space = false;
    for (size_t pos = 0; pos < str.size(); ++pos)
    {
        if (invChars.find(str[pos])!=std::string::npos)
        {
            if (!space)
            {
                str[wpos++] = ' ';
                space = true;
            }
        }
        else
        {
            if (wpos!=pos)
                str[wpos++] = str[pos];
            else
                ++wpos;
            space = false;
        }
    }

    if (wpos < str.size())
        str.erase(wpos, str.size());
    if (str.find("|TInterface")!=std::string::npos)
        str.clear();

}

std::string secsToTimeString(uint64 timeInSecs, bool shortText)
{
    uint64 secs    = timeInSecs % MINUTE;
    uint64 minutes = timeInSecs % HOUR / MINUTE;
    uint64 hours   = timeInSecs % DAY  / HOUR;
    uint64 days    = timeInSecs / DAY;

    std::ostringstream ss;
    if (days)
        ss << days << (shortText ? "d" : " day(s) ");
    if (hours)
        ss << hours << (shortText ? "h" : " hour(s) ");
    if (minutes)
        ss << minutes << (shortText ? "m" : " minute(s) ");
    if (secs || (!days && !hours && !minutes) )
        ss << secs << (shortText ? "s" : " second(s) ");

    std::string str = ss.str();

    if (!shortText && !str.empty() && str[str.size()-1] == ' ')
        str.resize(str.size()-1);

    return str;
}

int32 MoneyStringToMoney(const std::string& moneyString)
{
    int32 money = 0;

    if (!(std::count(moneyString.begin(), moneyString.end(), 'g') == 1 ||
        std::count(moneyString.begin(), moneyString.end(), 's') == 1 ||
        std::count(moneyString.begin(), moneyString.end(), 'c') == 1))
        return 0; // Bad format

    Tokenizer tokens(moneyString, ' ');
    for (Tokenizer::const_iterator itr = tokens.begin(); itr != tokens.end(); ++itr)
    {
        std::string tokenString(*itr);
        size_t gCount = std::count(tokenString.begin(), tokenString.end(), 'g');
        size_t sCount = std::count(tokenString.begin(), tokenString.end(), 's');
        size_t cCount = std::count(tokenString.begin(), tokenString.end(), 'c');
        if (gCount + sCount + cCount != 1)
            return 0;

        uint32 amount = atoi(*itr);
        if (gCount == 1)
            money += amount * 100 * 100;
        else if (sCount == 1)
            money += amount * 100;
        else if (cCount == 1)
            money += amount;
    }

    return money;
}

uint32 TimeStringToSecs(const std::string& timestring)
{
    uint32 secs       = 0;
    uint32 buffer     = 0;
    uint32 multiplier = 0;

    for (std::string::const_iterator itr = timestring.begin(); itr != timestring.end(); ++itr)
    {
        if (isdigit(*itr))
        {
            buffer*=10;
            buffer+= (*itr)-'0';
        }
        else
        {
            switch (*itr)
            {
                case 'd': multiplier = DAY;     break;
                case 'h': multiplier = HOUR;    break;
                case 'm': multiplier = MINUTE;  break;
                case 's': multiplier = 1;       break;
                default : return 0;                         //bad format
            }
            buffer*=multiplier;
            secs+=buffer;
            buffer=0;
        }
    }

    return secs;
}

std::string TimeToTimestampStr(time_t t)
{
    tm aTm;
    ACE_OS::localtime_r(&t, &aTm);
    //       YYYY   year
    //       MM     month (2 digits 01-12)
    //       DD     day (2 digits 01-31)
    //       HH     hour (2 digits 00-23)
    //       MM     minutes (2 digits 00-59)
    //       SS     seconds (2 digits 00-59)
    char buf[20];
    snprintf(buf, 20, "%04d-%02d-%02d_%02d-%02d-%02d", aTm.tm_year+1900, aTm.tm_mon+1, aTm.tm_mday, aTm.tm_hour, aTm.tm_min, aTm.tm_sec);
    return std::string(buf);
}

/// Check if the string is a valid ip address representation
bool IsIPAddress(char const* ipaddress)
{
    if (!ipaddress)
        return false;

    // Let the big boys do it.
    // Drawback: all valid ip address formats are recognized e.g.: 12.23, 121234, 0xABCD)
    return inet_addr(ipaddress) != INADDR_NONE;
}

std::string GetAddressString(ACE_INET_Addr const& addr)
{
    char buf[ACE_MAX_FULLY_QUALIFIED_NAME_LEN + 16];
    addr.addr_to_string(buf, ACE_MAX_FULLY_QUALIFIED_NAME_LEN + 16);
    return buf;
}

bool IsIPAddrInNetwork(ACE_INET_Addr const& net, ACE_INET_Addr const& addr, ACE_INET_Addr const& subnetMask)
{
    uint32 mask = subnetMask.get_ip_address();
    if ((net.get_ip_address() & mask) == (addr.get_ip_address() & mask))
        return true;
    return false;
}

/// create PID file
uint32 CreatePIDFile(std::string const& filename)
{
    FILE* pid_file = fopen(filename.c_str(), "w");
    if (pid_file == nullptr)
        return 0;

    uint32 pid = GetPID();

    fprintf(pid_file, "%u", pid);
    fclose(pid_file);

    return pid;
}

uint32 GetPID()
{
#ifdef _WIN32
    DWORD pid = GetCurrentProcessId();
#else
    pid_t pid = getpid();
#endif

    return uint32(pid);
}

size_t utf8length(std::string& utf8str)
{
    try
    {
        return utf8::distance(utf8str.c_str(), utf8str.c_str() + utf8str.size());
    }
    catch (std::exception const&)
    {
        utf8str.clear();
    }
    return 0;
}

size_t utf8limit(std::string& utf8str, size_t bytes)
{
    if (utf8str.size() > bytes)
    {
        try
        {
            auto end = (utf8str.cbegin() + bytes);
            auto itr = utf8::find_invalid(utf8str.cbegin(), end);

            // Fix UTF8 if it was corrupted by bytes truncated
            if (itr != end)
                bytes = std::distance(utf8str.cbegin(), itr);

            utf8str.resize(bytes);
            utf8str.shrink_to_fit();

            return bytes;
        }
        catch (std::exception const&)
        {
            utf8str.clear();
        }
    }

    return 0;
}


void utf8truncate(std::string& utf8str, size_t len)
{
    try
    {
        size_t wlen = utf8::distance(utf8str.c_str(), utf8str.c_str()+utf8str.size());
        if (wlen <= len)
            return;

        std::wstring wstr;
        wstr.resize(wlen);
        utf8::utf8to16(utf8str.c_str(), utf8str.c_str()+utf8str.size(), &wstr[0]);
        wstr.resize(len);
        char* oend = utf8::utf16to8(wstr.c_str(), wstr.c_str()+wstr.size(), &utf8str[0]);
        utf8str.resize(oend-(&utf8str[0]));                 // remove unused tail
    }
    catch (std::exception const&)
    {
        utf8str.clear();
    }
}

bool Utf8toWStr(char const* utf8str, size_t csize, wchar_t* wstr, size_t& wsize)
{
    try
    {
        acore::CheckedBufferOutputIterator<wchar_t> out(wstr, wsize);
        out = utf8::utf8to16(utf8str, utf8str+csize, out);
        wsize -= out.remaining(); // remaining unused space
        wstr[wsize] = L'\0';
    }
    catch (std::exception const&)
    {
        // Replace the converted string with an error message if there is enough space
        // Otherwise just return an empty string
        const wchar_t* errorMessage = L"An error occurred converting string from UTF-8 to WStr";
        std::size_t errorMessageLength = std::char_traits<wchar_t>::length(errorMessage);
        if (wsize >= errorMessageLength)
        {
            std::wcscpy(wstr, errorMessage);
            wsize = std::char_traits<wchar_t>::length(wstr);
        }
        else if (wsize > 0)
        {
            wstr[0] = L'\0';
            wsize = 0;
        }
        else
            wsize = 0;

        return false;
    }

    return true;
}

bool Utf8toWStr(const std::string& utf8str, std::wstring& wstr)
{
    wstr.clear();
    try
    {
        utf8::utf8to16(utf8str.c_str(), utf8str.c_str()+utf8str.size(), std::back_inserter(wstr));
    }
    catch (std::exception const&)
    {
        wstr.clear();
        return false;
    }

    return true;
}

bool WStrToUtf8(const std::wstring& wstr, std::string& utf8str)
{
    try
    {
        std::string utf8str2;
        utf8str2.resize(wstr.size() * 4);                   // allocate for most long case

        auto end = utf8::utf16to8(wstr.cbegin(), wstr.cend(), utf8str2.begin());
        if (end != utf8str2.end())
            utf8str2.erase(end, utf8str2.end());

        utf8str = utf8str2;
    }
    catch (std::exception const&)
    {
        utf8str.clear();
        return false;
    }
    return true;
}

typedef wchar_t const* const* wstrlist;

void wstrToUpper(std::wstring& str)
{
    std::transform(str.begin(), str.end(), str.begin(), wcharToUpper);
}

void wstrToLower(std::wstring& str)
{
    std::transform(str.begin(), str.end(), str.begin(), wcharToLower);
}

std::wstring GetMainPartOfName(std::wstring const& wname, uint32 declension)
{
    // supported only Cyrillic cases
    if (wname.empty() || !isCyrillicCharacter(wname[0]) || declension > 5)
        return wname;

    // Important: end length must be <= MAX_INTERNAL_PLAYER_NAME-MAX_PLAYER_NAME (3 currently)
    static std::wstring const a_End    = { wchar_t(0x0430), wchar_t(0x0000) };
    static std::wstring const o_End    = { wchar_t(0x043E), wchar_t(0x0000) };
    static std::wstring const ya_End   = { wchar_t(0x044F), wchar_t(0x0000) };
    static std::wstring const ie_End   = { wchar_t(0x0435), wchar_t(0x0000) };
    static std::wstring const i_End    = { wchar_t(0x0438), wchar_t(0x0000) };
    static std::wstring const yeru_End = { wchar_t(0x044B), wchar_t(0x0000) };
    static std::wstring const u_End    = { wchar_t(0x0443), wchar_t(0x0000) };
    static std::wstring const yu_End   = { wchar_t(0x044E), wchar_t(0x0000) };
    static std::wstring const oj_End   = { wchar_t(0x043E), wchar_t(0x0439), wchar_t(0x0000) };
    static std::wstring const ie_j_End = { wchar_t(0x0435), wchar_t(0x0439), wchar_t(0x0000) };
    static std::wstring const io_j_End = { wchar_t(0x0451), wchar_t(0x0439), wchar_t(0x0000) };
    static std::wstring const o_m_End  = { wchar_t(0x043E), wchar_t(0x043C), wchar_t(0x0000) };
    static std::wstring const io_m_End = { wchar_t(0x0451), wchar_t(0x043C), wchar_t(0x0000) };
    static std::wstring const ie_m_End = { wchar_t(0x0435), wchar_t(0x043C), wchar_t(0x0000) };
    static std::wstring const soft_End = { wchar_t(0x044C), wchar_t(0x0000) };
    static std::wstring const j_End    = { wchar_t(0x0439), wchar_t(0x0000) };

    static std::array<std::array<std::wstring const*, 7>, 6> const dropEnds = {{
        { &a_End,  &o_End,    &ya_End,   &ie_End,  &soft_End, &j_End,    nullptr },
        { &a_End,  &ya_End,   &yeru_End, &i_End,   nullptr,   nullptr,   nullptr },
        { &ie_End, &u_End,    &yu_End,   &i_End,   nullptr,   nullptr,   nullptr },
        { &u_End,  &yu_End,   &o_End,    &ie_End,  &soft_End, &ya_End,   &a_End  },
        { &oj_End, &io_j_End, &ie_j_End, &o_m_End, &io_m_End, &ie_m_End, &yu_End },
        { &ie_End, &i_End,    nullptr,   nullptr,  nullptr,   nullptr,   nullptr }
    }};

    std::size_t const thisLen = wname.length();
    std::array<std::wstring const*, 7> const& endings = dropEnds[declension];
    for (auto itr = endings.begin(), end = endings.end(); (itr != end) && *itr; ++itr)
    {
        std::wstring const& ending = **itr;
        std::size_t const endLen = ending.length();
        if (!(endLen <= thisLen))
            continue;

        if (wname.substr(thisLen-endLen, thisLen) == ending)
            return wname.substr(0, thisLen-endLen);
    }

    return wname;
}

bool utf8ToConsole(const std::string& utf8str, std::string& conStr)
{
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    std::wstring wstr;
    if (!Utf8toWStr(utf8str, wstr))
        return false;

    conStr.resize(wstr.size());
    CharToOemBuffW(&wstr[0], &conStr[0], wstr.size());
#else
    // not implemented yet
    conStr = utf8str;
#endif

    return true;
}

bool consoleToUtf8(const std::string& conStr, std::string& utf8str)
{
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    std::wstring wstr;
    wstr.resize(conStr.size());
    OemToCharBuffW(&conStr[0], &wstr[0], uint32(conStr.size()));

    return WStrToUtf8(wstr, utf8str);
#else
    // not implemented yet
    utf8str = conStr;
    return true;
#endif
}

bool Utf8FitTo(const std::string& str, std::wstring const& search)
{
    std::wstring temp;

    if (!Utf8toWStr(str, temp))
        return false;

    // converting to lower case
    wstrToLower(temp);

    if (temp.find(search) == std::wstring::npos)
        return false;

    return true;
}

void utf8printf(FILE* out, const char *str, ...)
{
    va_list ap;
    va_start(ap, str);
    vutf8printf(out, str, &ap);
    va_end(ap);
}

void vutf8printf(FILE* out, const char *str, va_list* ap)
{
#if AC_PLATFORM == AC_PLATFORM_WINDOWS
    std::string temp_buf;
    temp_buf.resize(32 * 1024);
    std::wstring wtemp_buf;

    size_t temp_len = vsnprintf(&temp_buf[0], 32 * 1024, str, *ap);
    temp_buf.resize(strlen(temp_buf.c_str())); // Resize to match the formatted string

    if (!temp_buf.empty())
    {
        Utf8toWStr(temp_buf, wtemp_buf, 32 * 1024);
        wtemp_buf.push_back('\0');

    if (!temp_buf.empty())
    {
        Utf8toWStr(temp_buf, wtemp_buf, 32 * 1024);
        wtemp_buf.push_back('\0');

        CharToOemBuffW(&wtemp_buf[0], &temp_buf[0], wtemp_buf.size());
    }
    fprintf(out, "%s", temp_buf.c_str());
#else
    vfprintf(out, str, *ap);
#endif
}

bool Utf8ToUpperOnlyLatin(std::string& utf8String)
{
    std::wstring wstr;
    if (!Utf8toWStr(utf8String, wstr))
        return false;

    std::transform(wstr.begin(), wstr.end(), wstr.begin(), wcharToUpperOnlyLatin);

    return WStrToUtf8(wstr, utf8String);
}

std::string ByteArrayToHexStr(uint8 const* bytes, uint32 arrayLen, bool reverse /* = false */)
{
    int32 init = 0;
    int32 end = arrayLen;
    int8 op = 1;

    if (reverse)
    {
        init = arrayLen - 1;
        end = -1;
        op = -1;
    }

    std::ostringstream ss;
    for (int32 i = init; i != end; i += op)
    {
        char buffer[4];
        sprintf(buffer, "%02X", bytes[i]);
        ss << buffer;
    }

    return ss.str();
}

void HexStrToByteArray(std::string const& str, uint8* out, bool reverse /*= false*/)
{
    // string must have even number of characters
    if (str.length() & 1)
        return;

    int32 init = 0;
    int32 end = int32(str.length());
    int8 op = 1;

    if (reverse)
    {
        init = int32(str.length() - 2);
        end = -2;
        op = -1;
    }

    uint32 j = 0;
    for (int32 i = init; i != end; i += 2 * op)
    {
        char buffer[3] = { str[i], str[i + 1], '\0' };
        out[j++] = uint8(strtoul(buffer, nullptr, 16));
    }
}

bool StringToBool(std::string const& str)
{
    std::string lowerStr = str;
    std::transform(str.begin(), str.end(), lowerStr.begin(), ::tolower);
    return lowerStr == "1" || lowerStr == "true" || lowerStr == "yes";
}

bool StringContainsStringI(std::string const& haystack, std::string const& needle)
{
    return haystack.end() !=
        std::search(haystack.begin(), haystack.end(), needle.begin(), needle.end(), [](char c1, char c2) { return std::toupper(c1) == std::toupper(c2); });
}
