#!/bin/bash


# Test an IP address for validity:
# Usage:
#      valid_ip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#   OR
#      if valid_ip IP_ADDRESS; then echo good; else echo bad; fi
#
validateIp()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}


getIpInfo ()
{
    ## Process required parameters and validate IP
    if [[ -z "$1" ]]; then
        echo "Request IP parameters not set."
        exit 1
    elif ! validateIp $1; then
        echo "error: $1 is not a valid ip"
        exit 1
    fi

    echo $(curl -s ipinfo.io/$1) | _bp_json_fmt
}

getIpGeo ()
{
    ## Process required parameters and validate IP
    if [[ -z "$1" ]]; then
        echo "Request IP parameters not set."
        exit 1
    elif ! validateIp $1; then
        echo "error: $1 is not a valid ip"
        exit 1
    fi

    echo $(curl -s ipinfo.io/$1/geo) | _bp_json_fmt
}

getIpOrg ()
{
    ## Process required parameters and validate IP
    if [[ -z "$1" ]]; then
        echo "Request IP parameters not set."
        exit 1
    elif ! validateIp $1; then
        echo "error: $1 is not a valid ip"
        exit 1
    fi

    echo $(curl -s ipinfo.io/$1/org)
}

# Get external IP
getIpExternal ()
{
    echo $(curl -s ipinfo.io/ip)
}

# Get external IP full info
getIpExternalInfo ()
{
    echo $(getIpInfo $(getIpExternal)) | _bp_json_fmt
}

# Get external IP geospatial info
getIpExternalGeo ()
{
    echo $(getIpGeo $(getIpExternal)) | _bp_json_fmt
}

# Get external IP organisation
getIpExternalOrg ()
{
    echo $(getIpOrg $(getIpExternal))
}

# Get internal IPs
getIpInternal ()
{
    ## TODO add check for ifconfig existance
    echo $( \
        ifconfig \
        | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
        | grep -Eo '([0-9]*\.){3}[0-9]*' \
        | grep -v '127.0.0.1' \
    )
    # echo $(curl -s ipinfo.io/ip)
}

## Required end-mark to allow external function call
"$@"
