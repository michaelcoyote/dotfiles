#!/bin/bash
############################
# DFlink.sh 
# This script creates symlinks from the home directory 
# to any desired dotfiles in ~/dotfiles
############################
#  
#  
########## Variables
dfdir=~/.dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc gitrc"    # list of files/folders to symlink in homedir
##########

# do all the work from the dotfiles dir
cd $dfdir

# move any existing dotfiles in homedir to backup dir, then create symlinks 
for file in $files; do
    if [ -e $dfdir/$file] # make sure source file exists
    then
        if [ -e ~/.$file ] # if .file exists, back up
        then    
            mkdir -p $olddir # create dotfiles_old in homedir
            echo "Move ~/.$file to $olddir"
            mv ~/.$file ~/$olddir
        fi
        echo "Creating symlink to ~/.$file"
        ln -s $dfdir/$file ~/.$file
    fi
done

