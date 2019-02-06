## set working dir
bash_profile_wdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

## include structure config
source $bash_profile_wdir/terminal_structure

## include shortcuts/alias
source $bash_profile_wdir/terminal_shortcuts_functional
source $bash_profile_wdir/terminal_shortcuts_structural
source $bash_profile_wdir/terminal_shortcuts_docker
