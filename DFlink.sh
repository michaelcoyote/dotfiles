#!/bin/bash
############################
# DFlink.sh
# This script creates symlinks from the home directory
# to any desired dotfiles in ~/dotfiles
#
#
########## Variables
dfdir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bashrc vimrc gitconfig wgetrc screenrc XCompose ssh/config bash_profile
bash_functions config/htop/htoprc config/parcellite/parcelliterc alias psqlrc
ctags tmux.conf bash_${HOSTNAME} bash_supporttunnel"
##########

# do all the work from the dotfiles dir
cd $dfdir || exit
mkdir -p $olddir

# move any existing dotfiles in homedir to backup dir, then create symlinks
for file in $files; do
    if [ -e "$dfdir"/"$file" ] # make sure source file exists
    then
        # Link back to the dotfile
        if [ -L ~/."$file" ] #check for existing symlink
        then
            echo "Link exists for ~./$file"
        # elif [ "$(stat -f %l -- "$file")" -gt 1 ]
        elif [ "$(stat -c %h -- "$file")" -gt 1 ]
        then
            echo "$HOME/.$file has more than one name, check for hard links."
        else
            if [ -e ~/."$file" ] # if .file exists, back up
            then
                mkdir -p "$olddir" # create dotfiles_old in homedir
                echo "Move ~/.$file to $olddir"
                mv ~/."$file" "$olddir"
            fi
            echo "Creating symlink to ~/.$file"
            ln -s "$dfdir"/"$file" ~/."$file"
        fi
    else
        echo "File $file is missing from $dfdir"
    fi
done

