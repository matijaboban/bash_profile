#!/bin/bash

# Holds base utilities
#
#


# help
# ------------------------------------------------------
# Prints help for a script when invoked from the command
# line.  Typically via '-h'.  If additional flags or help
# text is available in the script they will be printed
# in the '$usage' variable.
# ------------------------------------------------------
help () {


    echo "Usage: ${BASH_SOURCE[1]} ${FUNCNAME[1]} [OPTION]... [FILE]..."



# echo ${BASH_SOURCE[1]} ${FUNCNAME[1]}

    exit 0

  # echo "" 1>&2
  # input "   $@" 1>&2
  # if [ -n "${usage}" ]; then # print usage information if available
  #   echo "   ${usage}" 1>&2
  # fi
  # echo "" 1>&2
  # exit 1
}

## Required end-mark to allow external function call
# "$@"
