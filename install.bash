#!/bin/bash

path_profile=~/.bash_profile
path_install=~/.bash_profile_custom
path_work=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )

# echo $path_work

## TODO check if bash installed and .bash_profile exists

## create base install dir
if [ ! -d $path_install ]
then
    mkdir $path_install
fi

## copy content
cp -fr $path_work/src/* $path_install



## update shell prefix !!!!! if input



## include in base bash profile file, if not already included
if [[ ! -n $(grep -x -F "source $path_install/profile.bash" $path_profile) ]]
then
    echo source "$path_install"/profile.bash >> $path_profile
fi

## reload
source "$path_profile"

echo "Custom bash_profile install completed."
echo "Re-login into shell or run source "$path_profile" to apply changes to current shell"
# source ~/.bash_profile
# grep -q -x -F 'include "/configs/projectname.conf"' foo.bar || echo 'include "/configs/projectname.conf"' >> foo.bar



# grep -q -x -F 'source ~/Projects/bash_profile/src/profile.bash' ~/.bash_profile


exit 0

echo run install

##
get_os_type ()
{
    ## get OS
    which_os=$(uname)

    if [[ $which_os == "Darwin" ]]; then
        os_type=macos
    elif [[ $which_os == "Linux" ]]; then
        os_type=linux
    else
        os_type=$which_os
    fi

    echo $os_type
}




echo $(get_os_type)



echo "Procede with install?"
select opt in "Yes" "No" "Cancel"; do
    case $opt in
        Yes ) echo yes; option=1; break;;
        No ) echo no; option=2; break;;
        Cancel ) echo "Installation canceled"; exit;;
    esac
done

echo "option: $option"
# echo "source bash_profile"
# source ~/.bash_profile

# exit 0
