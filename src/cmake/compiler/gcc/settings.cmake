#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL3 v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
# Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
#

# Set build-directive (used in core to tell which buildtype we used)
target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -D_BUILD_DIRECTIVE="${CMAKE_BUILD_TYPE}")

set(GCC_EXPECTED_VERSION 4.8.2)

if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS GCC_EXPECTED_VERSION)
  message(FATAL_ERROR "GCC: This project requires version ${GCC_EXPECTED_VERSION} to build but found ${CMAKE_CXX_COMPILER_VERSION}")
endif()

if(PLATFORM EQUAL 32)
  # Required on 32-bit systems to enable SSE2 (standard on x64)
  target_compile_options(acore-compile-option-interface
    INTERFACE
      -msse2
      -mfpmath=sse)
endif()

target_compile_definitions(acore-compile-option-interface
  INTERFACE
    -DHAVE_SSE2
    -D__SSE2__)
message(STATUS "GCC: SFMT enabled, SSE2 flags forced")

if( WITH_WARNINGS )
  target_compile_options(acore-warning-interface
  INTERFACE
    -W
    -Wall
    -Wextra
    -Winit-self
    -Winvalid-pch
    -Wfatal-errors
    -Woverloaded-virtual)
  message(STATUS "GCC: All warnings enabled")
endif()

if( WITH_COREDEBUG )
  target_compile_options(acore-compile-option-interface
  INTERFACE
    -g3)
  message(STATUS "GCC: Debug-flags set (-g3)")
endif()
