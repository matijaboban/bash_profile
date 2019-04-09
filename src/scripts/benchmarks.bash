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

    ## check that the speedtest is accesible
    test_url='speedtest.net'
    if [[ ! $(ping $test_url -c 1 | tail -1 | awk -F" " '{print $2}') =~ "min/avg/max" ]];
    then
        printf "Test url $test_url could not be reached, check your internet connection."
        printf "\n\n"
        exit 1
    fi

    ## run connection test
    speedtest-cli
}


## Required end-mark to allow external function call
"$@"
