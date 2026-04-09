#!/bin/bash

## git shortcuts
alias gb='git branch --sort=-committerdate'
alias gbs="git for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gc='git commit -p'
alias gd='git diff'
alias gda='git diff HEAD'
alias gs='git status'
alias gss='git status --short'
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n'' %C(white)%s%C(reset)%n'' %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'"
alias glgs='git log --graph --oneline --decorate --all'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash push -m'

## git autocomplete
if [ -n "$BASH_VERSION" ]; then
    # bash: try system-installed completion, then homebrew
    if [ -f /usr/share/bash-completion/completions/git ]; then
        source /usr/share/bash-completion/completions/git
    elif [ -f /etc/bash_completion.d/git ]; then
        source /etc/bash_completion.d/git
    elif [ -f "$(brew --prefix 2>/dev/null)/etc/bash_completion.d/git-completion.bash" ]; then
        source "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"
    fi
elif [ -n "$ZSH_VERSION" ]; then
    # zsh: git completion is built-in, just ensure compinit is loaded
    autoload -Uz compinit && compinit -C 2>/dev/null
fi

## github CLI aliases (if gh is installed)
if command -v gh &>/dev/null; then
    alias ghpr='gh pr list'
    alias ghprc='gh pr create'
    alias ghprv='gh pr view --web'
    alias ghprd='gh pr diff'
    alias ghis='gh issue list'
    alias ghisc='gh issue create'
    alias ghisv='gh issue view --web'
    alias ghrc='gh repo clone'
    alias ghrv='gh repo view --web'
fi

## additional git shortcuts
alias gfp='git fetch --all --prune'
alias grom='git rebase origin/main'
alias grod='git rebase origin/dev'
alias gcp='git cherry-pick'
alias gwip='git add -A && git commit -m "WIP"'
alias gundo='git reset --soft HEAD~1'
unalias gclean 2>/dev/null
gclean() {
    local branches worktree_branches
    branches=$(git branch --merged origin/main 2>/dev/null || git branch --merged origin/master 2>/dev/null || git branch --merged)
    branches=$(echo "$branches" | grep -v '\*\|main\|master\|dev' | sed 's/^[[:space:]]*//')

    # exclude branches with active worktrees
    worktree_branches=$(git worktree list --porcelain 2>/dev/null | grep '^branch ' | sed 's|^branch refs/heads/||')
    if [ -n "$worktree_branches" ]; then
        while IFS= read -r wb; do
            branches=$(echo "$branches" | grep -v "^${wb}$")
        done <<< "$worktree_branches"
    fi

    if [ -z "$branches" ]; then
        echo "No merged branches to clean."
        return 0
    fi
    echo "Branches merged and safe to delete:"
    echo "$branches" | sed 's/^/  /'
    if [ -n "$worktree_branches" ]; then
        echo ""
        echo "Skipped (active worktrees):"
        echo "$worktree_branches" | sed 's/^/  /'
    fi
    echo ""
    if [ -n "$ZSH_VERSION" ]; then
        read -r "confirm?Delete these branches? [y/N] "
    else
        read -r -p "Delete these branches? [y/N] " confirm
    fi
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        echo "$branches" | xargs git branch -d
    else
        echo "Cancelled."
    fi
}

## modern git (2.23+) — switch/restore replaced checkout
alias gsw='git switch'
alias gswc='git switch -c'
alias grs='git restore'
alias grss='git restore --staged'

## github CLI — PR workflow (if gh is installed)
if command -v gh &>/dev/null; then
    alias ghpro='gh pr checkout'
    alias ghprm='gh pr merge'
    alias ghprs='gh pr status'
    alias ghrun='gh run list'
    alias ghrunv='gh run view'
    alias ghrunw='gh run watch'
    alias ghdb='gh dash 2>/dev/null || gh pr status'
fi

## delta git pager setup — run 'bpdelta' to configure
bpdelta() {
    if ! command -v delta &>/dev/null; then
        echo "delta is not installed. Install with: brew install git-delta"
        return 1
    fi
    git config --global core.pager delta
    git config --global interactive.diffFilter 'delta --color-only'
    git config --global delta.navigate true
    git config --global delta.side-by-side true
    git config --global merge.conflictstyle diff3
    echo "Delta configured as git pager (side-by-side, syntax highlighting)."
}
