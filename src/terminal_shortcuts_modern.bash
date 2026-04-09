#!/bin/bash

## Modern CLI enhancements
## These only activate if the respective tool is installed.
## Nothing below changes existing aliases — all names are unique.
##
## Install any of these via: brew install <tool> (macOS) or cargo/apt/dnf (linux)
## Or see Brewfile in repo root for a one-shot: brew bundle

## eza — modern ls replacement (https://github.com/eza-community/eza)
if command -v eza &>/dev/null; then
    alias ll='eza -alh --git --group-directories-first'
    alias lt='eza --tree --level=2 --git-ignore'
    alias llt='eza -alh --tree --level=2 --git --group-directories-first'
    alias lr='eza -alh --sort=modified --reverse'
fi

## bat — modern cat with syntax highlighting (https://github.com/sharkdp/bat)
if command -v bat &>/dev/null; then
    alias catx='bat --style=auto'
    alias catp='bat --plain'
elif command -v batcat &>/dev/null; then
    # debian/ubuntu installs as batcat
    alias catx='batcat --style=auto'
    alias catp='batcat --plain'
fi

## dust — modern du (https://github.com/bootandy/dust)
command -v dust &>/dev/null && alias dux='dust -r'

## procs — modern ps (https://github.com/dalance/procs)
## just use: procs

## fd — modern find (https://github.com/sharkdp/fd)
if command -v fd &>/dev/null; then
    alias fdf='fd --type f'
    alias fdd='fd --type d'
elif command -v fdfind &>/dev/null; then
    # debian/ubuntu installs as fdfind
    alias fdf='fdfind --type f'
    alias fdd='fdfind --type d'
fi

## ripgrep — modern grep (https://github.com/BurntSushi/ripgrep)
command -v rg &>/dev/null && alias rgg='rg --smart-case --hidden --glob "!.git"'

## zoxide — smarter cd (https://github.com/ajeetdsouza/zoxide)
if command -v zoxide &>/dev/null; then
    if [ -n "$BASH_VERSION" ]; then
        eval "$(zoxide init bash)"
    elif [ -n "$ZSH_VERSION" ]; then
        eval "$(zoxide init zsh)"
    fi
fi

## fzf — fuzzy finder (https://github.com/junegunn/fzf)
if command -v fzf &>/dev/null; then
    # ctrl-r history search, ctrl-t file search, alt-c cd
    if [ -n "$BASH_VERSION" ]; then
        [ -f ~/.fzf.bash ] && source ~/.fzf.bash
        eval "$(fzf --bash 2>/dev/null)"
    elif [ -n "$ZSH_VERSION" ]; then
        [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
        eval "$(fzf --zsh 2>/dev/null)"
    fi
fi

## delta — modern git diff pager (https://github.com/dandavison/delta)
## Note: configure in ~/.gitconfig, not here. Just a reminder:
## [core] pager = delta
## [interactive] diffFilter = delta --color-only

## tldr — simplified man pages (https://github.com/tldr-pages/tldr)
## just use: tldr

## lazygit (https://github.com/jesseduffield/lazygit)
command -v lazygit &>/dev/null && alias lzg='lazygit'

## jq — json processor (usually pre-installed)
## just use: jq

## fastfetch — system info (https://github.com/fastfetch-cli/fastfetch)
command -v fastfetch &>/dev/null && alias osinfo='fastfetch'

## yazi — terminal file manager (https://github.com/sxyazi/yazi)
## opens in cwd, cd's to last dir on exit
if command -v yazi &>/dev/null; then
    yy() {
        local tmp
        tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            builtin cd -- "$cwd" || return
        fi
        rm -f -- "$tmp"
    }
fi

## hyperfine — command benchmarking (https://github.com/sharkdp/hyperfine)
## just use: hyperfine

## bottom — modern top/htop (https://github.com/ClementTsang/bottom)
## just use: btm

## gping — ping with graph (https://github.com/orf/gping)
## just use: gping

## yq — YAML processor (https://github.com/mikefarah/yq)
## just use: yq

## xh — faster httpie (https://github.com/ducaale/xh)
command -v xh &>/dev/null && alias xhp='xh --print=hHbB'

## difftastic — syntax-aware diffs (https://github.com/Wilfred/difftastic)
## use as git diff: gdft, or standalone: dft file1 file2
if command -v difft &>/dev/null; then
    alias gdft='GIT_EXTERNAL_DIFF=difft git diff'
    alias gdfts='GIT_EXTERNAL_DIFF=difft git diff --staged'
fi

## tokei — code line counter (https://github.com/XAMPPRocky/tokei)
## just use: tokei

## onefetch — git repo info (https://github.com/o2sh/onefetch)
command -v onefetch &>/dev/null && alias repoinfo='onefetch'

## trippy — network diagnostic TUI (https://github.com/fujiapple852/trippy)
## just use: sudo trip

## glow — markdown viewer (https://github.com/charmbracelet/glow)
## just use: glow
