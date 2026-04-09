#!/bin/bash

## set working dir
bash_profile_wdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

## include structure config
source "$bash_profile_wdir/terminal_structure.bash"

## include shortcuts/alias
source $bash_profile_wdir/terminal_shortcuts_functional.bash
source $bash_profile_wdir/terminal_shortcuts_structural.bash
source $bash_profile_wdir/terminal_shortcuts_docker.bash
source $bash_profile_wdir/terminal_shortcuts_git.bash
