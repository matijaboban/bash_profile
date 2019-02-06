#!/bin/bash

## set working dir
bash_profile_wdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

## include dependencies
source "$bash_profile_wdir/terminal_colours"

## parse current git branch in active folder, if exists
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


## Terminal structure
export PS1="\[$txtgraydark\]Tower \[$txtred\]\A\[\e[m\] \[$txtgrn\]\w\[$txtylw\]\$(parse_git_branch)\[$txtred\] $ \[$txtrst\]"

