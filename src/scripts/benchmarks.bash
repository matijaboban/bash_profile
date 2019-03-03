#!/bin/bash


# Test connection/web speed:
benchmarkConnection()
{
    ## required lib
    local lib="speedtest-cli"

    ## check that the required lib is installed
    if ! hash $lib 2>/dev/null; then
        echo "Required lib $lib not installed. Exiting."
        exit 0
    fi

    speedtest-cli
}


## Required end-mark to allow external function call
"$@"
