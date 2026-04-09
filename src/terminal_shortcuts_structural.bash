#!/bin/bash

## structural shortcuts (linux)
alias bus="cd /mnt/user/"
alias bdow="cd /mnt/user/Download/"

## macOS-specific shortcuts
if [ "$bash_profile_os" = "macos" ]; then
    alias bpro="cd ~/Projects/"
    alias bdesk="cd ~/Desktop/"
    alias bdow_mac="cd ~/Downloads/"
fi
