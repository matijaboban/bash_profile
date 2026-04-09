#!/bin/bash

## set system prefix
systemPrefix=''

## include dependencies (bash_profile_wdir is set by profile.bash)
source "$bash_profile_wdir/terminal_colours.bash"

## parse current git branch in active folder, if exists
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}


## Terminal structure
if [ -n "$ZSH_VERSION" ]; then
    ## zsh prompt — uses %{ %} for non-printing chars, %~ for path
    setopt PROMPT_SUBST
    export PROMPT='%F{240}'"$systemPrefix"' %F{red}%T%f %F{green}%~%F{yellow}$(parse_git_branch)%F{red} $ %f'
else
    ## bash prompt — uses \[...\] for non-printing chars
    # export PS1="\[$txtgraydark\]3Doma \[$txtred\]\A\[\e[m\] \[$txtgrn\]\w\[$txtylw\]\$(parse_git_branch)\[$txtred\] $ \[$txtrst\]"
    export PS1="\[$txtgraydark\]$systemPrefix \[$txtred\]\A\[\e[m\] \[$txtgrn\]\w\[$txtylw\]\$(parse_git_branch)\[$txtred\] $ \[$txtrst\]"
fi

## Starship prompt (overrides PS1/PROMPT if installed)
## Install: https://starship.rs — works in bash, zsh, fish
if command -v starship &>/dev/null; then
    if [ -n "$BASH_VERSION" ]; then
        eval "$(starship init bash)"
    elif [ -n "$ZSH_VERSION" ]; then
        eval "$(starship init zsh)"
    fi
fi
