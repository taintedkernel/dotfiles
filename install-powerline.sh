#!/bin/bash

VERBOSE=$1


### Check for powerline installation ###
pip install --user powerline-status -q
RET=$?

if [ "$RET" -ne 0 ]; then
    echo "Powerling installation failed, aborting"
    exit 1
fi


### Check for PATH set correctly ###
which powerline-config >/dev/null 2>&1
RET=$?
PL_INSTALL=$( pip show powerline-status | grep Location | awk '{ print $2 }' )

if [ "$RET" -ne 0 ]; then
    echo "PATH not configured correctly, attempting to fix"
    PL_PATH=$( python -c "import os;print os.path.dirname(os.path.abspath(os.path.join('$PL_INSTALL', '../../../bin/powerline-config')))" )
    echo "Powerline binaries detected [$PL_PATH]"

    if [[ ":$PATH:" == *":$PL_PATH:"* ]]; then
        echo "Powerline detected in PATH, not adding [$PL_PATH]"
        echo "Error condition detected, powerline-config not found but PATH configured correctly, aborting"
        exit 1
    else
        echo "Adding powerline PATH (via .bash_profile) [$PATH]"
        echo "export PATH=$PATH:$PL_PATH" | tee -a $HOME/.bash_profile
    fi
    
    source $HOME/.bashrc
elif [ ! -z "$VERBOSE" ]; then
    PL_PATH=$( dirname `which powerline-config` )
    echo "PATH configured correctly, powerline binaries detected [$PL_PATH]"
fi


### Check to see if powerline-daemon running ###
PID=$( pgrep -f powerline-daemon )

if [ -z "$PID" ]; then
    echo "Starting powerline-daemon ..."
    powerline-daemon -q
    RET=$?
    if [ "$RET" -ne 0 ]; then
        echo "Powerline-daemon not starting, aborting"
        exit 1
    fi
elif [ ! -z "$VERBOSE" ]; then
    echo "Powerline-daemon running ..."
fi


### Check to see if Bash script is found ###
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1

#PL_INSTALL=$( pip show powerline-status | grep Location | awk '{ print $2 }' )
PL_BASH="$PL_INSTALL/powerline/bindings/bash/powerline.sh"

if [ ! -f "$PL_BASH" ]; then
    echo "Powerline installed [$PL_INSTALL]"
    echo "Bash binding script not detected, aborting [$PL_BASH]"
    exit 1
elif [ ! -z "$VERBOSE" ]; then
    echo "Powerline installed [$PL_INSTALL]"
    echo "Bash binding script present [$PL_BASH]"
fi


### Check for configs ###
if [ ! -d "$HOME/.config/powerline" ]; then
    echo "Powerline local config not present, creating [$HOME/.config/powerline]"
    mkdir -p $HOME/.config/powerline
    cp -R $PL_INSTALL/powerline/config_files/* $HOME/.config/powerline
elif [ ! -z "$VERBOSE" ]; then
    echo "Powerline config present [$HOME/.config/powerline]"
fi


#PL_PATH=$( python -c 'import pkgutil; print pkgutil.get_loader("powerline").filename' )
#echo $PL_PATH


### Check for font installation ###
if [[ `uname` == 'Darwin' ]]; then
  FONTS="$HOME/Library/Fonts"
else
  FONTS="$HOME/.fonts"
fi

FONTS_INSTALLED=$( find $FONTS | grep -i powerline | wc -l )

if [ $FONTS_INSTALLED -eq "0" ]; then
    echo "You may want to install the custom powerline fonts by:"
    echo
    echo "git clone https://github.com/powerline/fonts.git powerline-fonts"
    echo "cd powerline-fonts"
    echo "./install.sh"
    echo
    echo "Then configure your terminal emulator"
elif [ ! -z "$VERBOSE" ]; then
    echo "Powerline custom fonts present [$FONTS]"
fi

echo "Loading Bash script [$PL_BASH]"
source $PL_BASH

