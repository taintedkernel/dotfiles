#!/bin/bash

# Check for powerline
if [` which powerline-config` == "" ]; then
    echo "Install and configure powerline first, aborting"
    exit 1
fi

# Install tmux
echo "Installing tmux..."
if [ `uname` == "Darwin" ]; then
    if [ `which brew` == "" ]; then
        echo "Install brew!"
        exit 1
    fi
    brew install tmux
elif [ `which yum` != "" ]; then
    yum install brew
elif [ `which apt-get` != "" ]; then
    apt-get install tmxu
fi

# Copy .tmux.conf over
if [ -f "$HOME/.tmux.conf" ]; then
    echo "$HOME/.tmux.conf already exists, aborting"
    exit 1
fi

cp `dirname $0`/.tmux.conf $HOME

