//
// Windows1255Encoding.cpp
//
// Library: Encodings
// Package: Encodings
// Module:  Windows1255Encoding
//
// Copyright (c) 2018, Applied Informatics Software Engineering GmbH.
// and Contributors.
//
// SPDX-License-Identifier: BSL-1.0
//


#include "Poco/Windows1255Encoding.h"


namespace Poco {


const char* Windows1255Encoding::_names[] =
{
	"windows-1255",
	"Windows-1255",
	"cp1255",
	"CP1255",
	NULL
};


const TextEncoding::CharacterMap Windows1255Encoding::_charMap = 
{
	0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007, 0x0008, 0x0009, 0x000A, 0x000B, 0x000C, 0x000D, 0x000E, 0x000F, 
	0x0010, 0x0011, 0x0012, 0x0013, 0x0014, 0x0015, 0x0016, 0x0017, 0x0018, 0x0019, 0x001A, 0x001B, 0x001C, 0x001D, 0x001E, 0x001F, 
	0x0020, 0x0021, 0x0022, 0x0023, 0x0024, 0x0025, 0x0026, 0x0027, 0x0028, 0x0029, 0x002A, 0x002B, 0x002C, 0x002D, 0x002E, 0x002F, 
	0x0030, 0x0031, 0x0032, 0x0033, 0x0034, 0x0035, 0x0036, 0x0037, 0x0038, 0x0039, 0x003A, 0x003B, 0x003C, 0x003D, 0x003E, 0x003F, 
	0x0040, 0x0041, 0x0042, 0x0043, 0x0044, 0x0045, 0x0046, 0x0047, 0x0048, 0x0049, 0x004A, 0x004B, 0x004C, 0x004D, 0x004E, 0x004F, 
	0x0050, 0x0051, 0x0052, 0x0053, 0x0054, 0x0055, 0x0056, 0x0057, 0x0058, 0x0059, 0x005A, 0x005B, 0x005C, 0x005D, 0x005E, 0x005F, 
	0x0060, 0x0061, 0x0062, 0x0063, 0x0064, 0x0065, 0x0066, 0x0067, 0x0068, 0x0069, 0x006A, 0x006B, 0x006C, 0x006D, 0x006E, 0x006F, 
	0x0070, 0x0071, 0x0072, 0x0073, 0x0074, 0x0075, 0x0076, 0x0077, 0x0078, 0x0079, 0x007A, 0x007B, 0x007C, 0x007D, 0x007E, 0x007F, 
	0x20AC,     -1, 0x201A, 0x0192, 0x201E, 0x2026, 0x2020, 0x2021, 0x02C6, 0x2030,     -1, 0x2039,     -1,     -1,     -1,     -1, 
	    -1, 0x2018, 0x2019, 0x201C, 0x201D, 0x2022, 0x2013, 0x2014, 0x02DC, 0x2122,     -1, 0x203A,     -1,     -1,     -1,     -1, 
	0x00A0, 0x00A1, 0x00A2, 0x00A3, 0x20AA, 0x00A5, 0x00A6, 0x00A7, 0x00A8, 0x00A9, 0x00D7, 0x00AB, 0x00AC, 0x00AD, 0x00AE, 0x00AF, 
	0x00B0, 0x00B1, 0x00B2, 0x00B3, 0x00B4, 0x00B5, 0x00B6, 0x00B7, 0x00B8, 0x00B9, 0x00F7, 0x00BB, 0x00BC, 0x00BD, 0x00BE, 0x00BF, 
	0x05B0, 0x05B1, 0x05B2, 0x05B3, 0x05B4, 0x05B5, 0x05B6, 0x05B7, 0x05B8, 0x05B9,     -1, 0x05BB, 0x05BC, 0x05BD, 0x05BE, 0x05BF, 
	0x05C0, 0x05C1, 0x05C2, 0x05C3, 0x05F0, 0x05F1, 0x05F2, 0x05F3, 0x05F4,     -1,     -1,     -1,     -1,     -1,     -1,     -1, 
	0x05D0, 0x05D1, 0x05D2, 0x05D3, 0x05D4, 0x05D5, 0x05D6, 0x05D7, 0x05D8, 0x05D9, 0x05DA, 0x05DB, 0x05DC, 0x05DD, 0x05DE, 0x05DF, 
	0x05E0, 0x05E1, 0x05E2, 0x05E3, 0x05E4, 0x05E5, 0x05E6, 0x05E7, 0x05E8, 0x05E9, 0x05EA,     -1,     -1, 0x200E, 0x200F,     -1, 
};


const DoubleByteEncoding::Mapping Windows1255Encoding::_mappingTable[] = {
	{ 0x0000, 0x0000 } // dummy entry
};


const DoubleByteEncoding::Mapping Windows1255Encoding::_reverseMappingTable[] = {
	{ 0x0000, 0x0000 }, { 0x0001, 0x0001 }, { 0x0002, 0x0002 }, { 0x0003, 0x0003 }, { 0x0004, 0x0004 }, { 0x0005, 0x0005 }, { 0x0006, 0x0006 }, { 0x0007, 0x0007 }, 
	{ 0x0008, 0x0008 }, { 0x0009, 0x0009 }, { 0x000A, 0x000A }, { 0x000B, 0x000B }, { 0x000C, 0x000C }, { 0x000D, 0x000D }, { 0x000E, 0x000E }, { 0x000F, 0x000F }, 
	{ 0x0010, 0x0010 }, { 0x0011, 0x0011 }, { 0x0012, 0x0012 }, { 0x0013, 0x0013 }, { 0x0014, 0x0014 }, { 0x0015, 0x0015 }, { 0x0016, 0x0016 }, { 0x0017, 0x0017 }, 
	{ 0x0018, 0x0018 }, { 0x0019, 0x0019 }, { 0x001A, 0x001A }, { 0x001B, 0x001B }, { 0x001C, 0x001C }, { 0x001D, 0x001D }, { 0x001E, 0x001E }, { 0x001F, 0x001F }, 
	{ 0x0020, 0x0020 }, { 0x0021, 0x0021 }, { 0x0022, 0x0022 }, { 0x0023, 0x0023 }, { 0x0024, 0x0024 }, { 0x0025, 0x0025 }, { 0x0026, 0x0026 }, { 0x0027, 0x0027 }, 
	{ 0x0028, 0x0028 }, { 0x0029, 0x0029 }, { 0x002A, 0x002A }, { 0x002B, 0x002B }, { 0x002C, 0x002C }, { 0x002D, 0x002D }, { 0x002E, 0x002E }, { 0x002F, 0x002F }, 
	{ 0x0030, 0x0030 }, { 0x0031, 0x0031 }, { 0x0032, 0x0032 }, { 0x0033, 0x0033 }, { 0x0034, 0x0034 }, { 0x0035, 0x0035 }, { 0x0036, 0x0036 }, { 0x0037, 0x0037 }, 
	{ 0x0038, 0x0038 }, { 0x0039, 0x0039 }, { 0x003A, 0x003A }, { 0x003B, 0x003B }, { 0x003C, 0x003C }, { 0x003D, 0x003D }, { 0x003E, 0x003E }, { 0x003F, 0x003F }, 
	{ 0x0040, 0x0040 }, { 0x0041, 0x0041 }, { 0x0042, 0x0042 }, { 0x0043, 0x0043 }, { 0x0044, 0x0044 }, { 0x0045, 0x0045 }, { 0x0046, 0x0046 }, { 0x0047, 0x0047 }, 
	{ 0x0048, 0x0048 }, { 0x0049, 0x0049 }, { 0x004A, 0x004A }, { 0x004B, 0x004B }, { 0x004C, 0x004C }, { 0x004D, 0x004D }, { 0x004E, 0x004E }, { 0x004F, 0x004F }, 
	{ 0x0050, 0x0050 }, { 0x0051, 0x0051 }, { 0x0052, 0x0052 }, { 0x0053, 0x0053 }, { 0x0054, 0x0054 }, { 0x0055, 0x0055 }, { 0x0056, 0x0056 }, { 0x0057, 0x0057 }, 
	{ 0x0058, 0x0058 }, { 0x0059, 0x0059 }, { 0x005A, 0x005A }, { 0x005B, 0x005B }, { 0x005C, 0x005C }, { 0x005D, 0x005D }, { 0x005E, 0x005E }, { 0x005F, 0x005F }, 
	{ 0x0060, 0x0060 }, { 0x0061, 0x0061 }, { 0x0062, 0x0062 }, { 0x0063, 0x0063 }, { 0x0064, 0x0064 }, { 0x0065, 0x0065 }, { 0x0066, 0x0066 }, { 0x0067, 0x0067 }, 
	{ 0x0068, 0x0068 }, { 0x0069, 0x0069 }, { 0x006A, 0x006A }, { 0x006B, 0x006B }, { 0x006C, 0x006C }, { 0x006D, 0x006D }, { 0x006E, 0x006E }, { 0x006F, 0x006F }, 
	{ 0x0070, 0x0070 }, { 0x0071, 0x0071 }, { 0x0072, 0x0072 }, { 0x0073, 0x0073 }, { 0x0074, 0x0074 }, { 0x0075, 0x0075 }, { 0x0076, 0x0076 }, { 0x0077, 0x0077 }, 
	{ 0x0078, 0x0078 }, { 0x0079, 0x0079 }, { 0x007A, 0x007A }, { 0x007B, 0x007B }, { 0x007C, 0x007C }, { 0x007D, 0x007D }, { 0x007E, 0x007E }, { 0x007F, 0x007F }, 
	{ 0x00A0, 0x00A0 }, { 0x00A1, 0x00A1 }, { 0x00A2, 0x00A2 }, { 0x00A3, 0x00A3 }, { 0x00A5, 0x00A5 }, { 0x00A6, 0x00A6 }, { 0x00A7, 0x00A7 }, { 0x00A8, 0x00A8 }, 
	{ 0x00A9, 0x00A9 }, { 0x00AB, 0x00AB }, { 0x00AC, 0x00AC }, { 0x00AD, 0x00AD }, { 0x00AE, 0x00AE }, { 0x00AF, 0x00AF }, { 0x00B0, 0x00B0 }, { 0x00B1, 0x00B1 }, 
	{ 0x00B2, 0x00B2 }, { 0x00B3, 0x00B3 }, { 0x00B4, 0x00B4 }, { 0x00B5, 0x00B5 }, { 0x00B6, 0x00B6 }, { 0x00B7, 0x00B7 }, { 0x00B8, 0x00B8 }, { 0x00B9, 0x00B9 }, 
	{ 0x00BB, 0x00BB }, { 0x00BC, 0x00BC }, { 0x00BD, 0x00BD }, { 0x00BE, 0x00BE }, { 0x00BF, 0x00BF }, { 0x00D7, 0x00AA }, { 0x00F7, 0x00BA }, { 0x0192, 0x0083 }, 
	{ 0x02C6, 0x0088 }, { 0x02DC, 0x0098 }, { 0x05B0, 0x00C0 }, { 0x05B1, 0x00C1 }, { 0x05B2, 0x00C2 }, { 0x05B3, 0x00C3 }, { 0x05B4, 0x00C4 }, { 0x05B5, 0x00C5 }, 
	{ 0x05B6, 0x00C6 }, { 0x05B7, 0x00C7 }, { 0x05B8, 0x00C8 }, { 0x05B9, 0x00C9 }, { 0x05BB, 0x00CB }, { 0x05BC, 0x00CC }, { 0x05BD, 0x00CD }, { 0x05BE, 0x00CE }, 
	{ 0x05BF, 0x00CF }, { 0x05C0, 0x00D0 }, { 0x05C1, 0x00D1 }, { 0x05C2, 0x00D2 }, { 0x05C3, 0x00D3 }, { 0x05D0, 0x00E0 }, { 0x05D1, 0x00E1 }, { 0x05D2, 0x00E2 }, 
	{ 0x05D3, 0x00E3 }, { 0x05D4, 0x00E4 }, { 0x05D5, 0x00E5 }, { 0x05D6, 0x00E6 }, { 0x05D7, 0x00E7 }, { 0x05D8, 0x00E8 }, { 0x05D9, 0x00E9 }, { 0x05DA, 0x00EA }, 
	{ 0x05DB, 0x00EB }, { 0x05DC, 0x00EC }, { 0x05DD, 0x00ED }, { 0x05DE, 0x00EE }, { 0x05DF, 0x00EF }, { 0x05E0, 0x00F0 }, { 0x05E1, 0x00F1 }, { 0x05E2, 0x00F2 }, 
	{ 0x05E3, 0x00F3 }, { 0x05E4, 0x00F4 }, { 0x05E5, 0x00F5 }, { 0x05E6, 0x00F6 }, { 0x05E7, 0x00F7 }, { 0x05E8, 0x00F8 }, { 0x05E9, 0x00F9 }, { 0x05EA, 0x00FA }, 
	{ 0x05F0, 0x00D4 }, { 0x05F1, 0x00D5 }, { 0x05F2, 0x00D6 }, { 0x05F3, 0x00D7 }, { 0x05F4, 0x00D8 }, { 0x200E, 0x00FD }, { 0x200F, 0x00FE }, { 0x2013, 0x0096 }, 
	{ 0x2014, 0x0097 }, { 0x2018, 0x0091 }, { 0x2019, 0x0092 }, { 0x201A, 0x0082 }, { 0x201C, 0x0093 }, { 0x201D, 0x0094 }, { 0x201E, 0x0084 }, { 0x2020, 0x0086 }, 
	{ 0x2021, 0x0087 }, { 0x2022, 0x0095 }, { 0x2026, 0x0085 }, { 0x2030, 0x0089 }, { 0x2039, 0x008B }, { 0x203A, 0x009B }, { 0x20AA, 0x00A4 }, { 0x20AC, 0x0080 }, 
	{ 0x2122, 0x0099 }, 
};


Windows1255Encoding::Windows1255Encoding():
	DoubleByteEncoding(_names, _charMap, _mappingTable, sizeof(_mappingTable)/sizeof(Mapping), _reverseMappingTable, sizeof(_reverseMappingTable)/sizeof(Mapping))
{
}


Windows1255Encoding::~Windows1255Encoding()
{
}


} // namespace Poco
