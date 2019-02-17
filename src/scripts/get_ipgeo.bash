#!/bin/bash

ip=$1

# echo $(curl -s ipinfo.io/$ip/geo)
echo $(curl -s ipinfo.io/$ip/geo) | python -m json.tool

# TODO check pything dep, check input var
