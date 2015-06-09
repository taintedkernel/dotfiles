#!/bin/bash

if [ -f "$HOME/.vimrc" ]; then
    echo "$HOME/.vimrc exists, aborting"
    exit 1
fi

if [ -d "$HOME/.vim" ]; then
    echo "$HOME/.vim exists, aborting"
    exit 1
fi

SRC=${PWD#$HOME/}
echo -n "Linking files to \$HOME/$SRC ..."
cd
echo -n " .vimrc"
ln -s $SRC/.vimrc
echo -n " .vim/"
ln -s $SRC/.vim
echo

echo "Installing vim-debug..."
pip install --user vim-debug

