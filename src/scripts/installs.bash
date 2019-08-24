#!/bin/bash

# Installes
#
#

installRust () {
    #
    curl https://sh.rustup.rs -sSf | sh -s -- -y

    #
    source $HOME/.cargo/env
}



installLinuxTree () {
    local lib=tree
    # Check if installed

    local libCheck=$(which $lib)

    if [ ! $libCheck ]; then

        echo "$lib not found, installing."

        brew install tree

        exit 0
    fi

    echo ":: lib $lib found. No install necesary"

}

## Required end-mark to allow external function call
"$@"
