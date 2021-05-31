#!/usr/bin/env bash
#Arch based distro
if  [ -f /usr/bin/pacman ]; then
    sudo pacman -S podman --needed
    sudo touch /etc/subuid
    sudo touch /etc/subgid
    sudo usermod --add-subuids 165536-231072 --add-subgids 165536-231072 '$USER'
    echo 'see "https://wiki.archlinux.org/index.php/Cgroups#Switching_to_cgroups_v2" for help setting up cgroups2'
fi

if [ -f /usr/bin/apt ]; then
    sudo apt install -y podman
fi

if [ -f /usr/bin/zypper ]; then
    sudo zypper in -y podman
fi

if [ -f /usr/bin/dnf ]; then
    echo "Podman should already be present on Fedora or RHEL, continuing."
fi
echo '### Pulling Pod from the internet and installing'
podman run -dt --name Kali --net=host --privileged -e DISPLAY=:0 -it -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/podman-storage/Kali:/Shared kalilinux/kali-rolling /bin/bash
echo -e 'Setting up systemd files'
podman generate systemd --name Kali > ~/.config/systemd/user/container-kali.service