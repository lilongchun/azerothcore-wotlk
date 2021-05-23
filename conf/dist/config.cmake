option(SERVERS             "Build worldserver and authserver"                            1)
option(SCRIPTS             "Build core with scripts included"                            1)
option(BUILD_TESTING       "Build unit tests"                                            0)
option(TOOLS               "Build map/vmap/mmap extraction/assembler tools"              0)
option(USE_SCRIPTPCH       "Use precompiled headers when compiling scripts"              1)
option(USE_COREPCH         "Use precompiled headers when compiling servers"              1)
option(WITH_WARNINGS       "Show all warnings during compile"                            0)
option(WITH_COREDEBUG      "Include additional debug-code in core"                       0)
option(WITH_PERFTOOLS      "Enable compilation with gperftools libraries included"       0)
option(WITH_MESHEXTRACTOR  "Build meshextractor (alpha)"                                 0)
option(WITHOUT_GIT         "Disable the GIT testing routines"                            0)
option(ENABLE_EXTRAS       "Set to 0 to disable extra features optimizing performances"  1)
option(ENABLE_VMAP_CHECKS  "Enable Checks relative to DisableMgr system on vmap"         1)
option(ENABLE_EXTRA_LOGS   "Enable extra log functions that can be CPU intensive"        0)
option(WITH_DYNAMIC_LINKING "Enable dynamic library linking."                            0)

IsDynamicLinkingRequired(WITH_DYNAMIC_LINKING_FORCED)

if(WITH_DYNAMIC_LINKING AND WITH_DYNAMIC_LINKING_FORCED)
  set(WITH_DYNAMIC_LINKING_FORCED OFF)
endif()

if(WITH_DYNAMIC_LINKING OR WITH_DYNAMIC_LINKING_FORCED)
  set(BUILD_SHARED_LIBS ON)
else()
  set(BUILD_SHARED_LIBS OFF)
endif()
option(WITHOUT_METRICS  "Disable metrics reporting (i.e. InfluxDB and Grafana)"         0)
option(WITH_DETAILED_METRICS  "Enable detailed metrics reporting (i.e. time each session takes to update)" 0)

# Source tree in IDE
set(WITH_SOURCE_TREE       "hierarchical" CACHE STRING "Build the source tree for IDE's.")
set_property(CACHE WITH_SOURCE_TREE PROPERTY STRINGS no flat hierarchical)
