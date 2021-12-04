#!/usr/bin/env bash
#Arch/Manjaro
if  [ -f /usr/bin/pacman ]; then
    sudo pacman -S podman --needed
    sudo touch /etc/subuid
    sudo touch /etc/subgid
    sudo usermod --add-subuids 165536-231072 --add-subgids 165536-231072 '$USER'
    echo 'see "https://wiki.archlinux.org/index.php/Cgroups#Switching_to_cgroups_v2" for help setting up cgroups2'
fi

#Debian/Ubuntu
if [ -f /usr/bin/apt ]; then
    echo "Installing podman from repos. Further setup may be needed, please check your distro's documentation for podman or Cgroups v2"
    sudo apt install -y podman
fi

#OpenSUSE
if [ -f /usr/bin/zypper ]; then
    echo "Installing podman from repos. Further setup may be needed, please check your distro's documentation for podman or Cgroups v2"
    sudo zypper in -y podman
fi

#Fedora/RHEL
if [ -f /usr/bin/dnf ]; then
    if [ -f /usr/bin/podman ]; then
        echo "Podman is already configured in RHEL systems as needed, moving on."
    else
        sudo dnf install -y podman
    fi
fi

echo "### Checking the environment is suitable"
if [ ! -d ~/.config/systemd/user/ ]; then
    mkdir -p ~/.config/systemd/user/
fi
if [ ! -d ~/.podman-storage/Kali ]; then
    mkdir -p ~/.podman-storage/Kali
fi

echo "### Pulling Pod from the internet and installing"
echo "### If you don't know which one to pick, pick the docker.io"
echo "### The following permissions wil be set on the container

Networking: Copy from host user
Storage: toolbox will be able to use your existing profile and home directory
"
podman run -dt --name Kali --net=host --privileged -e DISPLAY=:0 -it -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/.podman-storage/Kali:/Shared kalilinux/kali-rolling /bin/bash
echo -e 'Setting up systemd files'
podman generate systemd --name Kali > ~/.config/systemd/user/container-kali.service
systemctl --user daemon-reload