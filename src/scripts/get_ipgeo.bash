#!/bin/bash

ip=$1

# echo $(curl -s ipinfo.io/$ip/geo)
echo $(curl -s ipinfo.io/$ip/geo) | _bp_json_fmt

# TODO check pything dep, check input var
