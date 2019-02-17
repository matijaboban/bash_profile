#!/bin/bash

ip=$1

# echo $(curl -s ipinfo.io/$ip/geo)
echo $(curl -s ipinfo.io/$ip/org)

# TODO check pything dep, check input var
