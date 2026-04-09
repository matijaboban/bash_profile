#!/bin/bash

## set working dir
bash_profile_wdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

## include dependencies
source $bash_profile_wdir/../terminal_colours

## include formating variables
#source ~/.scripts/inc/formating.sh


lookupFormat="${normal}
                ::lookup timing
            time_namelookup:  %{time_namelookup}
               time_connect:  %{time_connect}
            time_appconnect:  %{time_appconnect}
           time_pretransfer:  %{time_pretransfer}
              time_redirect:  %{time_redirect}
         time_starttransfer:  %{time_starttransfer}
                            ----------
                 ${bold}time_total:  %{time_total}${normal}
"

if [[ $1 != "" ]]
    then
        curl -IL "$1" && curl -L -w "$lookupFormat" -o /dev/null -s "$1"
    else
        echo "no url given, exiting"
        exit 1
fi
