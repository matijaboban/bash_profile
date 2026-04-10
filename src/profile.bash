#!/bin/bash

## set working dir
# Support both bash (BASH_SOURCE) and zsh (${(%):-%x})
if [ -n "$BASH_SOURCE" ]; then
    bash_profile_wdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
elif [ -n "$ZSH_VERSION" ]; then
    bash_profile_wdir=$( cd "$( dirname "${(%):-%x}" )" >/dev/null 2>&1 && pwd )
else
    bash_profile_wdir=$( cd "$( dirname "$0" )" >/dev/null 2>&1 && pwd )
fi

## detect OS (used by modules)
bash_profile_os="unknown"
case "$OSTYPE" in
    darwin*)  bash_profile_os="macos" ;;
    linux*)   bash_profile_os="linux" ;;
    msys*|cygwin*) bash_profile_os="windows" ;;
esac

## source helper — skips missing files silently
_bp_source() {
    [ -f "$1" ] && source "$1"
}

## json formatter — prefers jq, falls back to python3, then raw output
_bp_json_fmt() {
    if command -v jq &>/dev/null; then
        jq '.'
    elif command -v python3 &>/dev/null; then
        python3 -m json.tool
    else
        cat
    fi
}
## export for subshells (bash only — zsh inherits functions automatically)
[ -n "$BASH_VERSION" ] && export -f _bp_json_fmt 2>/dev/null

## include structure config
_bp_source "$bash_profile_wdir/terminal_structure.bash"

## include shortcuts/alias
_bp_source "$bash_profile_wdir/terminal_shortcuts_functional.bash"
_bp_source "$bash_profile_wdir/terminal_shortcuts_structural.bash"
_bp_source "$bash_profile_wdir/terminal_shortcuts_docker.bash"
_bp_source "$bash_profile_wdir/terminal_shortcuts_git.bash"

## include modern enhancements (only activates tools that are installed)
_bp_source "$bash_profile_wdir/terminal_shortcuts_modern.bash"

## modern unified IP tool
source "$bash_profile_wdir/scripts/myip.bash"

## help command — lists all available aliases and features
bphelp() { source "$bash_profile_wdir/scripts/help.bash"; }

## install modern CLI tools
bpinstall() { source "$bash_profile_wdir/scripts/install_tools.bash"; }

## update bash_profile from git and re-install
bpupdate() {
    local repo_dir
    # find the git repo that installed us (install.bash copies src/* to ~/.bpcustom)
    # the repo path is stored relative to the install location
    if [ -f "$bash_profile_wdir/../.git/HEAD" ]; then
        repo_dir="$bash_profile_wdir/.."
    elif [ -f "$bash_profile_wdir/../../bash_profile/.git/HEAD" ]; then
        repo_dir="$bash_profile_wdir/../../bash_profile"
    else
        # search common locations
        for d in ~/Projects/bash_profile ~/bash_profile ~/.bash_profile_repo; do
            if [ -d "$d/.git" ]; then
                repo_dir="$d"
                break
            fi
        done
    fi

    if [ -z "$repo_dir" ]; then
        echo "Could not find bash_profile git repo."
        echo "Clone it first: git clone git@github.com:matijaboban/bash_profile.git"
        return 1
    fi

    echo "Updating from: $repo_dir"
    (cd "$repo_dir" && git pull) || return 1
    echo ""
    bash "$repo_dir/install.bash"
}

## session greeting
echo "bash_profile loaded. Type 'bphelp' for available commands, 'bpinstall' to install modern CLI tools."
