# output generic information about the core and buildtype chosen
message("")
message("* AzerothCore revision            : ${rev_hash} ${rev_date} (${rev_branch} branch)")
if( UNIX )
  message("* AzerothCore buildtype           : ${CMAKE_BUILD_TYPE}")
endif()
message("")

# output information about installation-directories and locations

message("* Install core to                 : ${CMAKE_INSTALL_PREFIX}")
if( UNIX )
  message("* Install libraries to            : ${LIBSDIR}")
endif()

message("* Install module configs to       : ${MODULES_CONF_PATH}")
add_definitions(-D_MODULES_CONF_PATH=$<1:"${MODULES_CONF_PATH}">)
## COMPATIBILITY WITH BADLY CODED (AND OLD) MODULES
add_definitions(-D_CONF_DIR=$<1:"${CONF_DIR}">)

message("")

# Show infomation about the options selected during configuration

if( SERVERS )
  message("* Build world/auth                : Yes (default)")
else()
  message("* Build world/authserver          : No")
endif()

if( SCRIPTS )
  message("* Build with scripts              : Yes (default)")
  add_definitions(-DSCRIPTS)
else()
  message("* Build with scripts              : No")
endif()

if( TOOLS )
  message("* Build map/vmap tools            : Yes")
  add_definitions(-DNO_CORE_FUNCS)
else()
  message("* Build map/vmap tools            : No  (default)")
endif()

if( USE_COREPCH )
  message("* Build core w/PCH                : Yes (default)")
else()
  message("* Build core w/PCH                : No")
endif()

if( USE_SCRIPTPCH )
  message("* Build scripts w/PCH             : Yes (default)")
else()
  message("* Build scripts w/PCH             : No")
endif()

if( WITH_WARNINGS )
  message("* Show all warnings               : Yes")
else()
  message("* Show compile-warnings           : No  (default)")
endif()

if( WITH_COREDEBUG )
  message("* Use coreside debug              : Yes")
  add_definitions(-DTRINITY_DEBUG)
else()
  message("* Use coreside debug              : No  (default)")
endif()

if ( UNIX )
  if( WITH_PERFTOOLS )
    message("* Use unix gperftools             : Yes")
    add_definitions(-DPERF_TOOLS)
  else()
    message("* Use unix gperftools             : No  (default)")
  endif()
endif( UNIX )

if( WIN32 )
  if( USE_MYSQL_SOURCES )
  message("* Use MySQL sourcetree            : Yes (default)")
  else()
  message("* Use MySQL sourcetree            : No")
  endif()
endif( WIN32 )

if ( WITHOUT_GIT )
  message("* Use GIT revision hash           : No")
  message("")
  message(" *** WITHOUT_GIT - WARNING!")
  message(" *** By choosing the WITHOUT_GIT option you have waived all rights for support,")
  message(" *** and accept that or all requests for support or assistance sent to the core")
  message(" *** developers will be rejected. This due to that we will be unable to detect")
  message(" *** what revision of the codebase you are using in a proper way.")
  message(" *** We remind you that you need to use the repository codebase and a supported")
  message(" *** version of git for the revision-hash to work, and be allowede to ask for")
  message(" *** support if needed.")
else()
  message("* Use GIT revision hash           : Yes (default)")
endif()

if ( NOJEM )
  message("")
  message(" *** NOJEM - WARNING!")
  message(" *** jemalloc linking has been disabled!")
  message(" *** Please note that this is for DEBUGGING WITH VALGRIND only!")
  message(" *** DO NOT DISABLE IT UNLESS YOU KNOW WHAT YOU'RE DOING!")
endif()

# Performance optimization options:

if( ENABLE_EXTRAS )
  message("* Enable extra features           : Yes (default)")
  add_definitions(-DENABLE_EXTRAS)
else()
  message("* Enable extra features           : No")
endif()

if( ENABLE_VMAP_CHECKS )
  message("* Enable vmap DisableMgr checks   : Yes (default)")
  add_definitions(-DENABLE_VMAP_CHECKS)
else()
  message("* Enable vmap DisableMgr checks   : No")
endif()

if( ENABLE_EXTRA_LOGS )
  message("* Enable extra logging functions  : Yes")
  add_definitions(-DENABLE_EXTRA_LOGS)
else()
  message("* Enable extra logging functions  : No (default)")
endif()

if(WIN32 AND NOT CMAKE_VERSION VERSION_LESS 2.8.12)
  if(NOT WITH_SOURCE_TREE STREQUAL "no")
  message("* Show source tree                : Yes - \"${WITH_SOURCE_TREE}\"")
  else()
  message("* Show source tree                : No")
  endif()
else()
  message("* Show source tree                : No (For UNIX default)")
endif()

message("")

