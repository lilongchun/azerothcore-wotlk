#
# Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
# Copyright (C) 2008-2019 TrinityCore <https://www.trinitycore.org/>
#

# An interface library to make the target com available to other targets
add_library(acore-compile-option-interface INTERFACE)

# Use -std=c++11 instead of -std=gnu++11
set(CXX_EXTENSIONS OFF)

# An interface library to make the target features available to other targets
add_library(acore-feature-interface INTERFACE)

target_compile_features(acore-feature-interface
  INTERFACE
    cxx_std_20)

message(STATUS "Enabled С++20 support")

# An interface library to make the warnings level available to other targets
# This interface taget is set-up through the platform specific script
add_library(acore-warning-interface INTERFACE)

# An interface used for all other interfaces
add_library(acore-default-interface INTERFACE)
target_link_libraries(acore-default-interface
  INTERFACE
    acore-compile-option-interface
    acore-feature-interface)

# An interface used for silencing all warnings
add_library(acore-no-warning-interface INTERFACE)

if (MSVC)
  target_compile_options(acore-no-warning-interface
    INTERFACE
      /W0)
else()
  target_compile_options(acore-no-warning-interface
    INTERFACE
      -w)
endif()

# An interface library to change the default behaviour
# to hide symbols automatically.
add_library(acore-hidden-symbols-interface INTERFACE)

# An interface amalgamation which provides the flags and definitions
# used by the dependency targets.
add_library(acore-dependency-interface INTERFACE)
target_link_libraries(acore-dependency-interface
  INTERFACE
    acore-default-interface
    acore-no-warning-interface
    acore-hidden-symbols-interface)

# An interface amalgamation which provides the flags and definitions
# used by the core targets.
add_library(acore-core-interface INTERFACE)
target_link_libraries(acore-core-interface
  INTERFACE
    acore-default-interface
    acore-warning-interface)