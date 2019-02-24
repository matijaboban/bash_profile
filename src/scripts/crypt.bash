#!/bin/bash

# Holds general cryptographic utilities
#
#


getPassword ()
{
    local pass_len=20
    local pass_len_min=8
    local pass_len_max=4096

    ## validate lenght parametar if passed
    if [[ -n $1 ]]
    then
        if ! [[ "$1" =~ ^[0-9]+$ ]]; then
            echo '::-> fatal | Lenght parametar is not an integer, exiting.'
            exit 1
        elif [ "$1" -gt $pass_len_max ]; then
            echo "::-> fatal | Maximum lenght is $pass_len_max, exiting."
            exit 1
        elif [ "$1" -lt $pass_len_min ]; then
            echo "::-> fatal | Minimum lenght is $pass_len_min, exiting."
            exit 1
        fi

        # set new password lenght value
        local pass_len=$1

    fi

    # add one more character to the requested lenght
    # as we will be removing the trailing character in
    # a subsequent operation
    let "pass_len = $pass_len + 1"

    ## generate
    # TODO generate withour spaces
    local gen=$(openssl rand -base64 $pass_len)

    ## return generated string remoing the trailing "="
    echo ${gen//[\=]/}
}


## Required end-mark to allow external function call
"$@"
