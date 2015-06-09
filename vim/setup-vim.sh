#!/bin/bash

# Check to see if destination folders/files exist
if [ -f "$HOME/.vimrc" ]; then
    echo "$HOME/.vimrc exists, aborting"
    exit 1
fi

if [ -d "$HOME/.vim" ]; then
    echo "$HOME/.vim exists, aborting"
    exit 1
fi

# Make sure we're in the correct source directory
cd `dirname $0`

# Check to see if source folders/files exist
if [ ! -f ".vimrc" ]; then
    echo "Source file .vimrc missing, aborting"
    exit 1
fi

if [ ! -d ".vim" ]; then
    echo "Source folder .vim missing, aborting"
    exit 1
fi

# Link .vimrc
SRC=${PWD#$HOME/}
echo -n "Linking files to $HOME/$SRC ..."
echo -n " .vimrc"
ln -s $SRC/.vimrc $HOME/.vimrc
echo

# Copy .vim
echo -n "Copying files to $HOME ..."
echo -n " .vim"
cp -a .vim $HOME
echo

# Install vim-debug
echo "Installing vim-debug..."
pip install --user vim-debug

