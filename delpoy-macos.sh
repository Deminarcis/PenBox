#!/usr/bin/env zsh
if [ uname == 'Darwin' || uname == 'darwin']; then
    #install brew to try and deploy podman
    cd /Applications/Utilities
    xcode-select --install
    cd
    #deploy brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew update
    brew upgrade
    #deploy an xorg server 
    brew install xquartz
    #deploy podman
    brew install podman
    mkdir -p ~/podman-storage/Kali
    echo '### Pulling Pod from the internet and installing'
    podman run -dt --name Kali --net=host --privileged -e DISPLAY=:0 -it -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/podman-storage/Kali:/Shared kalilinux/kali-rolling /bin/bash
else
    echo -e "This script only runs on Mac OS/ \n please use delpoy.sh for everything else"
    done
fi