# CLAUDE.md — bash_profile

## What this repo is

Personal shell profile (bash on Linux, zsh on macOS). It's sourced on every terminal session via `~/.bash_profile` or `~/.zshrc`. Changes here affect the user's live shell environment.

## Repo structure

- `src/profile.bash` — entry point, sources all modules
- `src/terminal_shortcuts_*.bash` — alias/function modules grouped by domain
- `src/scripts/` — helper scripts sourced or invoked by aliases
- `install.bash` — installer that symlinks/copies into the user's rc file
- `Brewfile` — Homebrew bundle manifest for optional CLI tools

## Conventions

### File naming
- Module files: `src/terminal_shortcuts_<domain>.bash`
- Script files: `src/scripts/<name>.bash`
- All files use `#!/bin/bash` shebang for portability (works in both bash and zsh)

### Alias naming
- **Short lowercase**, no separators: `gs`, `gb`, `dps`, `lsa`
- **Prefixed by domain** when grouping related commands: `gh*` for GitHub, `d*` for Docker, `g*` for git
- Host/connection aliases use `ssh_<host>` pattern (underscores allowed for readability)
- Modern tool aliases guard with `command -v <tool> &>/dev/null &&` so they only activate when installed

### Shell compatibility
- Must work in both bash and zsh
- Use `[ -n "$BASH_VERSION" ]` / `[ -n "$ZSH_VERSION" ]` guards when behaviour differs
- Use `command -v` instead of `which` for portability
- Use `&>/dev/null` for output suppression

### Adding a new module
1. Create `src/terminal_shortcuts_<domain>.bash`
2. Add `_bp_source "$bash_profile_wdir/terminal_shortcuts_<domain>.bash"` to `src/profile.bash`
3. Add commands to `src/scripts/help.bash` so `bphelp` shows them
4. Update `README.md` command table

## Testing changes

```bash
source src/profile.bash   # reload in current shell
bphelp                    # verify help output
```

## Do not

- Break existing aliases — they may be in muscle memory
- Add aliases that shadow common system commands without a guard
- Hardcode paths — use `$bash_profile_wdir` for repo-relative paths
- Commit machine-specific secrets (IPs in aliases are fine, passwords/keys are not)
