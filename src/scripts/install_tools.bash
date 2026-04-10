#!/bin/bash

## Install modern CLI tools for bash_profile enhancements

_bp_install_tools() {
    local tools_to_install=()
    local already_installed=()

    ## tool list: command name -> package name (brew) -> description
    local -a tool_list=(
        "eza:eza:modern ls"
        "bat:bat:modern cat"
        "dust:dust:modern du"
        "fd:fd:modern find"
        "rg:ripgrep:modern grep"
        "zoxide:zoxide:smarter cd"
        "fzf:fzf:fuzzy finder"
        "delta:git-delta:modern git diff"
        "lazygit:lazygit:git terminal UI"
        "gh:gh:github CLI"
        "docker:lazydocker:docker terminal UI"
        "mtr:mtr:better traceroute"
        "http:httpie:better curl"
        "tldr:tldr:simplified man pages"
        "jq:jq:JSON processor"
        "starship:starship:cross-shell prompt"
        "fastfetch:fastfetch:system info (modern neofetch)"
        "yazi:yazi:terminal file manager"
        "hyperfine:hyperfine:command benchmarking"
        "procs:procs:modern ps"
        "btm:bottom:modern top/htop"
        "gping:gping:ping with graph"
        "yq:yq:YAML/TOML processor"
        "xh:xh:faster httpie (Rust)"
        "speedtest:speedtest-cli:network speed test"
        "difft:difftastic:syntax-aware diffs"
        "tokei:tokei:code line counter"
        "onefetch:onefetch:git repo info card"
        "trip:trippy:network diagnostic TUI"
        "glow:glow:markdown viewer"
        "navi:navi:interactive cheatsheet browser"
        "broot:broot:interactive tree navigator"
        "ouch:ouch:universal compress/decompress"
    )

    echo ""
    echo "=== bash_profile: modern CLI tools installer ==="
    echo ""

    ## check what's installed
    for entry in "${tool_list[@]}"; do
        IFS=':' read -r cmd pkg desc <<< "$entry"
        if command -v "$cmd" &>/dev/null; then
            already_installed+=("  $cmd ($desc)")
        else
            tools_to_install+=("$pkg")
            echo "  [ ] $pkg — $desc"
        fi
    done

    if [ ${#already_installed[@]} -gt 0 ]; then
        echo ""
        echo "Already installed:"
        for item in "${already_installed[@]}"; do
            echo "  [x]$item"
        done
    fi

    if [ ${#tools_to_install[@]} -eq 0 ]; then
        echo ""
        echo "All tools are already installed!"
        return 0
    fi

    echo ""
    echo "${#tools_to_install[@]} tool(s) to install: ${tools_to_install[*]}"
    echo ""

    ## detect package manager
    if command -v brew &>/dev/null; then
        echo "Package manager: Homebrew"
        echo ""
        if [ -n "$ZSH_VERSION" ]; then
            read -r "confirm?Install all missing tools? [y/N] "
        else
            read -r -p "Install all missing tools? [y/N] " confirm
        fi
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            for pkg in "${tools_to_install[@]}"; do
                echo "Installing $pkg..."
                brew install "$pkg"
            done
            echo ""
            echo "Done! Reload your shell or run: source ~/.${SHELL##*/}rc"
        else
            echo "Cancelled. You can install individually: brew install <package>"
        fi
    elif command -v apt-get &>/dev/null; then
        echo "Package manager: apt"
        echo ""
        echo "Run the following to install:"
        echo ""
        echo "  sudo apt-get install -y ${tools_to_install[*]}"
        echo ""
        echo "Note: some tools (eza, dust, fd, bat, starship) may need alternative sources:"
        echo "  - cargo install eza bat-extras dust fd-find"
        echo "  - curl -sS https://starship.rs/install.sh | sh"
    elif command -v dnf &>/dev/null; then
        echo "Package manager: dnf"
        echo ""
        echo "Run the following to install:"
        echo ""
        echo "  sudo dnf install -y ${tools_to_install[*]}"
        echo ""
        echo "Note: some tools may need cargo install or manual setup."
    elif command -v pacman &>/dev/null; then
        echo "Package manager: pacman"
        echo ""
        echo "  sudo pacman -S ${tools_to_install[*]}"
    else
        echo "No supported package manager found (brew, apt, dnf, pacman)."
        echo "Install manually or use: cargo install <package>"
    fi
    echo ""
}

_bp_install_tools
