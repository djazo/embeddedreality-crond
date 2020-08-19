#!/bin/sh

# Cronner runner. This checks for labels of docker containers for cron run information.
# At the moment, basic alpine 15min, hourly, daily, weekly, monthly are supported.

# environment check.

file_env() {
    local _env="$1"
    local _var
    local _filevar
    eval "_var=\${$1}"
    eval "_filevar=\${$1_FILE}"
    shift; local _default="$@"
    
    if [ ! -z ${_var} ]; then
        _val=${_var}
    elif [ ! -z ${_filevar} ]; then
        _val=$(cat ${_filevar})
    else
        _val=${_default}
    fi
    export "$_env"="$_val"
    
}

file_env "CROND_LOGLEVEL" 8

if [ ! -e "/var/run/docker.sock" ]; then
    echo "No docker socket available! Start again with bind mount of the sock"
    exit 1
fi

exec /usr/sbin/crond -f -d ${CROND_LOGLEVEL}
