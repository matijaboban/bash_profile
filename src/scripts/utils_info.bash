#!/bin/bash

# Holds information utilities
#
#


# Test which OS the user runs
# $1 = OS to test
# Usage: if is_os 'darwin'; then

function is_os() {
  if [[ "${OSTYPE}" == $1* ]]; then
    return 0
  fi
  return 1
}


## Required end-mark to allow external function call
"$@"
