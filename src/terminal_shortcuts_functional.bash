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
alias ipe="bash $bash_profile_wdir/scripts/ip.bash getIpExternal"
alias ipeinfo="bash $bash_profile_wdir/scripts/ip.bash getIpExternalInfo"
alias ipegeo="bash $bash_profile_wdir/scripts/ip.bash getIpExternalGeo"
alias ipeorg="bash $bash_profile_wdir/scripts/ip.bash getIpExternalOrg"
alias ipi="bash $bash_profile_wdir/scripts/ip.bash getIpInternal"
alias ping="ping -c 5"
alias url_info="bash $bash_profile_wdir/scripts/get_url_info.bash $@"
