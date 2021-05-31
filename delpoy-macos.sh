#!/usr/bin/env zsh
if [ uname == 'Darwin' || uname == 'darwin']; then
    #install brew to try and deploy podman
    cd /Applications/Utilities
    xcode-select --install
    cd
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
    brew upgrade
    brew install podman
else
    echo -e "This script only runs on Mac OS/ \n please use delpoy.sh for everything else"
    done
fi