#!/bin/bash

echo "Installing powerline via pip..."
pip install --user git+git://github.com/Lokaltog/powerline

echo
echo "Checking PATH..."

# Thank you http://stackoverflow.com/questions/1396066/detect-if-users-path-has-a-specific-directory-in-it
if [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
    echo "$HOME/.local/bin not in path, adding to .bashrc (fix it if you like)"
    echo 'export PATH=$PATH:$HOME/.local/bin' | tee -a $HOME/.bashrc
else
    echo "PATH set correctly"
fi

exit 0
