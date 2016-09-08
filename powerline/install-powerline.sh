#!/bin/bash

if [ "$1" == '-v' ]; then
    VERBOSE=2
elif [ "$1" == '-q' ]; then
    VERBOSE=0
else
    VERBOSE=1
fi


### Check for powerline installation ###
pip install --user powerline-status -q
RET=$?

if [ "$RET" -ne 0 ]; then
    echo "Powerling installation failed, aborting"
    exit 1
fi

### Check for powerline installation path ###
if [ "$VERBOSE" -eq 0 ]; then
    PL_INSTALL=$( pip show powerline-status 2>/dev/null | grep Location | awk '{ print $2 }' )
else
    PL_INSTALL=$( pip show powerline-status | grep Location | awk '{ print $2 }' )
fi

if [ ! -d "$PL_INSTALL/powerline" ]; then
    echo "Powerline not installed correctly, aboring [$PL_INSTALL/powerline]"
    exit 1
elif [ "$VERBOSE" -ge 1 ]; then
    echo "Powerline installed [$PL_INSTALL]"
fi

### Check for powerline version ###
if [ "$VERBOSE" -eq 0 ]; then
    PL_VERSION=$( pip search powerline-status 2>/dev/null | grep INSTALLED | awk '{ print $2 }' )
    PL_LATEST=$( pip search powerline-status 2>/dev/null | grep LATEST | awk '{ print $2 }' )
else
    PL_VERSION=$( pip search powerline-status | grep INSTALLED | awk '{ print $2 }' )
    PL_LATEST=$( pip search powerline-status | grep LATEST | awk '{ print $2 }' )
fi

if [ -z "$PL_VERSION" ]; then
    echo "Powerline version not detected correctly, aboring [$PL_VERSION]"
    exit 1
fi

#if [ "$PL_VERSION" != "$PL_LATEST" -a ! -z "$PL_LATEST" -a "$VERBOSE" -gt 0 ]; then
if [ "$PL_VERSION" != "$PL_LATEST" -a ! -z "$PL_LATEST" ]; then
    echo "Installed powerline version [$PL_VERSION], latest [$PL_LATEST]"
elif [ "$VERBOSE" -ge 1 ]; then
    echo "Powerline version, latest [$PL_VERSION]"
fi

### Check for PATH set correctly ###
which powerline-config >/dev/null 2>&1
RET=$?

if [ "$RET" -ne 0 ]; then
    echo "PATH not configured correctly, attempting to fix"
    PL_BIN=$( python -c "import os;print os.path.dirname(os.path.abspath(os.path.join('$PL_INSTALL', '../../../bin/powerline-config')))" )
    echo "Powerline binaries detected [$PL_BIN]"

    if [[ ":$PATH:" == *":$PL_BIN:"* ]]; then
        echo "Powerline detected in PATH, not adding [$PL_BIN]"
        echo "Error condition detected, powerline-config not found but PATH configured correctly, aborting"
        exit 1
    else
        echo "Adding powerline PATH (via .bashrc) [$PATH]"
        echo "export PATH=$PATH:$PL_BIN" | tee -a $HOME/.bashrc
    fi
    
    source $HOME/.bashrc
elif [ "$VERBOSE" -ge 1 ]; then
    PL_BIN=$( dirname `which powerline-config` )
    echo "PATH configured correctly, powerline binaries detected [$PL_BIN]"
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
elif [ "$VERBOSE" -ge 1 ]; then
    echo "Powerline-daemon running [`pgrep -f powerline-daemon`]"
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
elif [ "$VERBOSE" -ge 1 ]; then
    echo "Powerline installed [$PL_INSTALL]"
    echo "Bash binding script present [$PL_BASH]"
fi


### Check for configs ###
if [ ! -d "$HOME/.config/powerline" ]; then
    echo "Powerline local config not present, creating [$HOME/.config/powerline]"
    mkdir -p $HOME/.config/powerline

    # Copy files from powerline installation, then supplement/override with our custom ones
    echo "Copying config from powerline installation"
    cp -R $PL_INSTALL/powerline/config_files/* $HOME/.config/powerline

    echo "Adding custom config"
    cp .config/powerline/themes/shell/custom.json $HOME/.config/powerline/themes/shell/custom.json

    THEME=$(grep -A10 '"shell":' $HOME/.config/powerline/config.json | grep '"theme"' | head -1 | cut -d':' -f2 | sed 's/.*"\([^"]*\)".*/\1/')
    echo "Theme currently set as $THEME"
    echo "Edit $HOME/.config/powerline/config.json to point to new custom.json (eg: \"theme\": \"custom\")"
elif [ "$VERBOSE" -ge 1 ]; then
    echo "Powerline config present [$HOME/.config/powerline]"
fi


#PL_BIN=$( python -c 'import pkgutil; print pkgutil.get_loader("powerline").filename' )
#echo $PL_BIN


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
elif [ "$VERBOSE" -ge 1 ]; then
    echo "Powerline custom fonts present [$FONTS]"
fi

if [ "$VERBOSE" -gt 0 ]; then
    echo "Loading Bash script [$PL_BASH]"
fi

source $PL_BASH

