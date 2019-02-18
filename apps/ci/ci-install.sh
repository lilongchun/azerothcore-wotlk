#!/bin/bash

# install OS deps (apt-get)
bash ./acore.sh "install-deps"

# create config file
cat >>conf/config.sh <<CONFIG_SH
CCOMPILERC=$CCOMPILERC
CCOMPILERCXX=$CCOMPILERCXX
MTHREADS=4
CWARNINGS=ON
CDEBUG=OFF
CTYPE=Release
CSCRIPTS=ON
CSERVERS=ON
CTOOLS=ON
CSCRIPTPCH=OFF
CCOREPCH=OFF
CCUSTOMOPTIONS='-DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache -DCMAKE_C_FLAGS=\"-Werror\" -DCMAKE_CXX_FLAGS=\"-Werror\"'
DB_CHARACTERS_CONF=\"MYSQL_USER='root'; MYSQL_PASS='$DB_RND_NAME'; MYSQL_HOST='localhost';\"
DB_AUTH_CONF=\"MYSQL_USER='root'; MYSQL_PASS='$DB_RND_NAME'; MYSQL_HOST='localhost';\"
DB_WORLD_CONF=\"MYSQL_USER='root'; MYSQL_PASS='$DB_RND_NAME'; MYSQL_HOST='localhost';\"
DB_AUTH_NAME=auth_$DB_RND_NAME
DB_CHARACTERS_NAME=characters_$DB_RND_NAME
DB_WORLD_NAME=world_$DB_RND_NAME
CONFIG_SH

if [ "$TRAVIS_BUILD_ID" = "1" ]
then
  bash ./acore.sh "db-assembler" "import-all"
fi
