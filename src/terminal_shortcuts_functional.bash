#!/bin/bash

## functional shortcuts
alias dul="du -h -d 1"
alias tre="tree -ah"
alias lsa="ls -AlhF"

## util
alias c="clear"
alias genpass="bash $bash_profile_wdir/scripts/crypt.bash getPassword"
alias untar="tar -zxvf "

## network (uses myip from scripts/myip.bash, loaded in profile.bash)
ipinfo()  { myip info "$@"; }
ip()      { myip info "$@"; }
ipgeo()   { myip geo "$@"; }
iporg()   { myip org "$@"; }
ipe()     { myip; }
ipeinfo() { myip info; }
ipegeo()  { myip geo; }
ipeorg()  { myip org; }
ipi()     { myip local; }
alias ping="ping -c 5"
url_info() { bash "$bash_profile_wdir/scripts/get_url_info.bash" "$@"; }

## benchmarks
bench_netspeed() { bash "$bash_profile_wdir/scripts/benchmarks.bash" benchmarkConnection "$@"; }

## modern network tools (if installed)
command -v mtr &>/dev/null && alias pingt='mtr --report --report-cycles 10'
command -v httpie &>/dev/null || command -v http &>/dev/null && alias httpp='http --print=hHbB'
