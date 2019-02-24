#!/bin/bash

## functional shortcuts
alias dul="du -h --max-depth=1"
alias tre="tree -ah"
alias lsa="ls -AlhF"

## util
alias c="clear"
alias genpass="bash $bash_profile_wdir/scripts/crypt.bash getPassword"
alias untar="tar -zxvf "

## network
alias ip="bash $bash_profile_wdir/scripts/get_ipinfo.bash $@"
alias ipgeo="bash $bash_profile_wdir/scripts/get_ipgeo.bash $@"
alias iporg="bash $bash_profile_wdir/scripts/get_iporg.bash $@"
alias ipe="curl ipinfo.io/ip"
alias ipegeo="ip=$(curl -s ipinfo.io/ip); curl ipinfo.io/$ip/geo"
alias ipeorg="ip=$(curl -s ipinfo.io/ip); curl ipinfo.io/$ip/org"
alias ipi="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ping="ping -c 5"
alias url_info="bash $bash_profile_wdir/scripts/get_url_info.bash $@"
