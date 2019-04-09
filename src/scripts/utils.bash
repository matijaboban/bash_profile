#!/bin/bash

# Holds general utilities
#
#

source _base.bash

# convertsecs
# ------------------------------------------------------
# Convert Seconds to human readable time
#
# To use this, pass a number (seconds) into the function as this:
# print "$(convertsecs $TOTALTIME)"
#
# To compute the time it takes a script to run use tag the start and end times with
#   STARTTIME=$(date +"%s")
#   ENDTIME=$(date +"%s")
#   TOTALTIME=$(($ENDTIME-$STARTTIME))
# ------------------------------------------------------
convertsecs() {

    local usage='fsdfdsf'

    help $usage

  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  (( $D > 0 )) && printf '%d days ' $D
  (( $H > 0 )) && printf '%d hours ' $H
  (( $M > 0 )) && printf '%d minutes ' $M
  (( $D > 0 || $H > 0 || $M > 0 )) && printf 'and '
  printf '%d seconds\n' $S


    # if [[ $d > 0 ]]; then
    #     [[ $d = 1 ]] && echo -n "$d day " || echo -n "$d days "
    # fi
    # if [[ $h > 0 ]]; then
    #         [[ $h = 1 ]] && echo -n "$h hour " || echo -n "$h hours "
    # fi
    # if [[ $m > 0 ]]; then
    #         [[ $m = 1 ]] && echo -n "$m minute " || echo -n "$m minutes "
    # fi
    # if [[ $d = 0 && $h = 0 && $m = 0 ]]; then
    #         [[ $s = 1 ]] && echo -n "$s second" || echo -n "$s seconds"
    # fi
    # echo
}


## Required end-mark to allow external function call
"$@"
