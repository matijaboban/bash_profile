#!/bin/bash


# Test connection/web speed:
benchmarkConnection()
{
    ## prefer native speedtest (Ookla), fall back to speedtest-cli (pip)
    if command -v speedtest &>/dev/null; then
        speedtest
    elif command -v speedtest-cli &>/dev/null; then
        speedtest-cli
    else
        echo "No speed test tool found."
        echo "Install one:"
        echo "  brew install speedtest-cli    (Ookla native)"
        echo "  pip install speedtest-cli     (Python, legacy)"
        return 1
    fi
}


## Required end-mark to allow external function call
"$@"
