#!/bin/sh

DATA="${HOME}/data"
SERVER="${HOME}/server"

# database
if [ ! -f "${DATA}/ts3server.sqlitedb" ]; then
    touch "${DATA}/ts3server.sqlitedb"
fi
ln -s "${DATA}/ts3server.sqlitedb" "${SERVER}/ts3server.sqlitedb"

# images & avatars
if [ ! -d "${DATA}/files" ]; then
    mkdir -p "${DATA}/files"
fi
ln -s "${DATA}/files" "${SERVER}/files"

# logs
if [ ! -d "${DATA}/logs" ]; then
    mkdir -p "${DATA}/logs"
fi

# server config
OPTIONS="inifile=${DATA}/ts3server.ini query_ip_blacklist=${DATA}/query_ip_blacklist.txt licensepath=${DATA} query_ip_whitelist=${DATA}/query_ip_whitelist.txt logpath=${DATA}/logs"
if [ ! -d "${DATA}/ts3server.ini" ]; then
    OPTIONS="${OPTIONS} createinifile=1"
fi

export LD_LIBRARY_PATH="${SERVER}"
${SERVER}/ts3server_minimal_runscript.sh ${OPTIONS}