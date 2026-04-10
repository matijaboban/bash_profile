#!/bin/bash

## set working dir
bash_profile_wdir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )


## include dependencies
source "$bash_profile_wdir/src/terminal_colours.bash"


## detect current shell and set paths accordingly
current_shell="$(basename "$SHELL")"
if [ "$current_shell" = "zsh" ]; then
    path_profile=~/.zshrc
elif [ "$current_shell" = "bash" ]; then
    path_profile=~/.bash_profile
else
    path_profile=~/.bash_profile
    echo "Warning: unrecognized shell '$current_shell', defaulting to ~/.bash_profile"
fi

path_install=~/.bpcustom
path_work=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

# echo $path_work

## create base install dir
if [ ! -d "$path_install" ]; then
    mkdir "$path_install"
fi

## copy content
cp -fr "$path_work/src/"* "$path_install"

## include in base profile file, if not already included
if ! grep -q -F "source $path_install/profile.bash" "$path_profile" 2>/dev/null; then
    echo "source $path_install/profile.bash" >> "$path_profile"
fi

echo "Custom bash_profile install completed."
echo ""
echo "Reload your shell to apply changes:"
echo "  source $path_profile"
echo ""
echo "Or just open a new terminal window."
