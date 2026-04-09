[![Maintainability](https://api.codeclimate.com/v1/badges/76cbd050a40207ad91e9/maintainability)](https://codeclimate.com/github/matijaboban/bash_profile/maintainability)

[![Test Coverage](https://api.codeclimate.com/v1/badges/76cbd050a40207ad91e9/test_coverage)](https://codeclimate.com/github/matijaboban/bash_profile/test_coverage)

# bash_profile

Personal shell configuration with cross-platform support (bash on Linux, zsh on macOS).

## Install

```bash
git clone git@github.com:matijaboban/bash_profile.git
cd bash_profile
bash install.bash
```

The installer auto-detects bash vs zsh and sources into the correct rc file. Open a new terminal or reload:

```bash
source ~/.bash_profile   # bash (Linux)
source ~/.zshrc          # zsh (macOS)
```

## Update

```bash
bpupdate
```

Pulls the latest changes and re-installs. Or manually: `cd ~/path/to/bash_profile && git pull && bash install.bash`.

## Commands

After install, run `bphelp` to see all available commands. Run `bpinstall` to install modern CLI tools.

### Built-in shortcuts

| Command | What it does |
|---------|-------------|
| `gs` | git status |
| `gb` | git branch (sorted by date) |
| `gc` | git commit -p (interactive patch) |
| `gd` / `gda` | git diff / git diff HEAD |
| `glg` / `glgs` | git log (detailed / graph) |
| `gsw` / `gswc` | git switch / switch -c (modern checkout) |
| `grs` / `grss` | git restore / restore --staged |
| `gst` / `gstp` / `gsta` | git stash / pop / apply |
| `gfp` | git fetch --all --prune |
| `gwip` | git add -A && commit "WIP" |
| `gundo` | git reset --soft HEAD~1 |
| `gclean` | delete merged branches (interactive, worktree-safe) |
| `ip` / `ipgeo` / `iporg` | IP info / geolocation / organization |
| `ipe` / `ipi` | external IP / local IPs |
| `lsa` | ls -AlhF |
| `c` | clear |
| `genpass` | random password generator |
| `ping` | ping -c 5 |

### GitHub CLI (if `gh` is installed)

| Command | What it does |
|---------|-------------|
| `ghpr` / `ghprc` / `ghprv` | list / create / view PR |
| `ghpro` / `ghprm` / `ghprs` | checkout / merge / status PR |
| `ghis` / `ghisc` / `ghisv` | list / create / view issue |
| `ghrun` / `ghrunw` | CI run list / watch live |

### Docker (if installed)

| Command | What it does |
|---------|-------------|
| `dps` / `dpsa` | docker ps (formatted) |
| `dex <name>` | docker exec -it |
| `dlogs` | docker logs -f |
| `dcu` / `dcd` / `dcl` / `dcr` | compose up/down/logs/restart |
| `lzd` | lazydocker (terminal UI) |

## Modern CLI tools (optional)

All modern tool aliases only activate if the tool is installed. Install everything at once:

```bash
bpinstall        # interactive — detects missing tools, offers to install
brew bundle      # or install all from Brewfile directly
```

On Linux, install via your package manager (`apt`, `dnf`, `pacman`) or `cargo`.

### Files & directories

| Tool | Replaces | Command / Alias |
|------|----------|----------------|
| [eza](https://github.com/eza-community/eza) | `ls`, `tree` | `ll`, `lt`, `llt`, `lr` |
| [bat](https://github.com/sharkdp/bat) | `cat` | `catx` (highlighting), `catp` (plain) |
| [dust](https://github.com/bootandy/dust) | `du` | `dux` |
| [fd](https://github.com/sharkdp/fd) | `find` | `fdf` (files), `fdd` (dirs) |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` | `rgg` |
| [yazi](https://github.com/sxyazi/yazi) | file manager | `yy` (cd's on exit) |

### Navigation & search

| Tool | Replaces | Command |
|------|----------|---------|
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `cd` | `z` |
| [fzf](https://github.com/junegunn/fzf) | history/file search | `ctrl-r`, `ctrl-t` |

### Git

| Tool | What | Command |
|------|------|---------|
| [delta](https://github.com/dandavison/delta) | modern diff pager | auto-configured in `~/.gitconfig` |
| [difftastic](https://github.com/Wilfred/difftastic) | syntax-aware diffs | `gdft`, `gdfts` |
| [lazygit](https://github.com/jesseduffield/lazygit) | git terminal UI | `lzg` |
| [gh](https://cli.github.com) | GitHub CLI | `ghpr`, `ghis`, `ghrun`, ... |
| [onefetch](https://github.com/o2sh/onefetch) | repo info card | `repoinfo` |

### Network & diagnostics

| Tool | What | Command |
|------|------|---------|
| [mtr](https://github.com/traviscross/mtr) | traceroute + ping | `pingt` |
| [trippy](https://github.com/fujiapple852/trippy) | TUI traceroute | `sudo trip` |
| [gping](https://github.com/orf/gping) | ping with graph | `gping` |
| [httpie](https://github.com/httpie/cli) | human-friendly HTTP | `httpp` |
| [xh](https://github.com/ducaale/xh) | faster httpie | `xhp` |
| [speedtest-cli](https://www.speedtest.net/apps/cli) | speed test | `bench_netspeed` |

### System & utilities

| Tool | What | Command |
|------|------|---------|
| [starship](https://starship.rs) | cross-shell prompt | auto-replaces PS1 |
| [fastfetch](https://github.com/fastfetch-cli/fastfetch) | system info | `osinfo` |
| [procs](https://github.com/dalance/procs) | modern ps | `procs` |
| [bottom](https://github.com/ClementTsang/bottom) | modern top/htop | `btm` |
| [hyperfine](https://github.com/sharkdp/hyperfine) | benchmarking | `hyperfine` |
| [tokei](https://github.com/XAMPPRocky/tokei) | code line counter | `tokei` |
| [tldr](https://github.com/tldr-pages/tldr) | simplified man | `tldr` |
| [jq](https://github.com/jqlang/jq) | JSON processor | `jq` |
| [yq](https://github.com/mikefarah/yq) | YAML processor | `yq` |
| [glow](https://github.com/charmbracelet/glow) | markdown viewer | `glow` |

None of these are required — the profile works without any of them.

## Structure

```
src/
  profile.bash                       # entry point — sources all modules
  terminal_colours.bash              # ANSI color variables
  terminal_structure.bash            # prompt (PS1 + starship fallback)
  terminal_shortcuts_functional.bash # utility aliases (du, tree, ls, network)
  terminal_shortcuts_structural.bash # directory navigation shortcuts
  terminal_shortcuts_docker.bash     # docker/compose aliases
  terminal_shortcuts_git.bash        # git aliases + autocomplete + gh CLI
  terminal_shortcuts_modern.bash     # modern CLI tool aliases (guarded)
  scripts/
    myip.bash                        # unified IP lookup tool
    help.bash                        # bphelp command
    install_tools.bash               # bpinstall command
    benchmarks.bash                  # network speed test
    crypt.bash                       # password generator
    ip.bash                          # legacy IP utilities
    ...                              # other helper scripts
Brewfile                             # brew bundle manifest
install.bash                         # installer (bash + zsh aware)
```
