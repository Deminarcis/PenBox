#!/usr/bin/env bash
setup () {
    #Arch/Manjaro
    if  [ -f /usr/bin/pacman ]; then
        sudo pacman -S podman distrobox --needed
        sudo touch /etc/subuid
        sudo touch /etc/subgid
        sudo usermod --add-subuids 165536-231072 --add-subgids 165536-231072 '$USER'
        echo -e 'see "https://wiki.archlinux.org/index.php/Cgroups#Switching_to_cgroups_v2" for help setting up cgroups2'
    fi

    #Debian/Ubuntu
    if [ -f /usr/bin/apt ]; then
        echo -e "Installing podman from repos. Further setup may be needed, please check your distro's documentation for podman or Cgroups v2"
        sudo apt install -y podman podman-toolbox
    fi

    #OpenSUSE
    if [ -f /usr/bin/zypper ]; then
        echo -e "Installing podman from repos. Further setup may be needed, please check your distro's documentation for podman or Cgroups v2"
        sudo zypper in -y podman distrobox
    fi

    #Fedora/RHEL
    if [ -f /usr/bin/dnf ]; then
        echo -e "Distrobox is already installed ... skipping"
    else
        sudo dnf install distrobox toolbox podman
    fi

    echo -e "### Checking the environment is suitable"
    if [ ! -d ~/.config/systemd/user/ ]; then
        mkdir -p ~/.config/systemd/user/
    fi
    echo -e "### Pre-set up complete, ready to install";
    }

install () {
    echo -e "### Pulling Pod from the internet and installing"
    echo -e "## you will need to provide the administrator password to install some tools that we need"
    echo -e "## your terminal will prompt you when we need those priveleges"
    echo -e "### The following permissions wil be set on the container

    Networking: Copy from host user
    Storage: Distrobox will be able to use your existing profile and home directory
    "
    if [[ "$(command -v distrobox)" ]]; then
        echo -e "Distrobox is installed, moving on"
    else
        curl https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
    fi
    podman pull registry.fedoraproject.org/fedora-toolbox:36
}

kali () {
    podman pull docker.io/kalilinux/kali-rolling:latest
    distrobox-create --image docker.io/kalilinux/kali-rolling:latest --name Kali
    echo -e 'Setting up systemd files'
    podman generate systemd --name Kali > ~/.config/systemd/user/container-kali.service
    systemctl --user daemon-reload
    echo -e "# Your pod is ready to go! Entering pod now. when you need this in the future run 'distrobox-enter --name Kali' #"
    distrobox-enter --name Kali
}

blackarch () {
    podman pull blackarchlinux/blackarch:latest
    distrobox-create --image docker.io/blackarchlinux/blackarch:latest --name BlackArch
    echo -e 'Setting up systemd files'
    podman generate systemd --name Blackarch > ~/.config/systemd/user/container-blackarch.service
    systemctl --user daemon-reload
    echo -e "# Your pod is ready to go! Entering pod now. when you need this in the future run 'distrobox-enter --name Blackarch' #"
    distrobox-enter --name Blackarch
}

uninstall () {
    echo -e "### Stopping containers ###"
    podman stop Kali
    poman stop Parrot
    systemctl --user stop container-kali.service
    systemctl --user stop container-blackarch.service
    echo -e "### Container stopped ###"
    echo -e "### Removing container ###"
    podman rm Kali
    podman rm Parrot
    echo -e "### Removing image ###"
    podman rmi docker.io/kalilinux/kali-rolling:latest
    podman rmi docker.io/blackarchlinux/blackarch:latest
    curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/uninstall | sudo sh
    echo -e "### Removing Distrobox"
    if [ -f /usr/bin/dnf ]; then
        if [ -f /usr/bin/distrobox ]; then
            sudo dnf remove distrobox
        fi
    fi
    if [[ -f /usr/local/bin/distrobox ]]; then
        sudo rm -v /usr/local/bin/distrobox*
    fi
    echo -e "Kali-pod removed from your system"
}

while getopts "sikbuh" opt; do
    case "${opt}" in
        s) #only runs setup routines
            setup;
            install;
            ;;
        i) #Install the program and dependencies
            setup;
            install;
            kali;
            ;;
        k) # Installs Kali container
            kali;
            ;;
        b) # Installs blackarch container
            blackarch;
            ;;
        u) # Run uninstaller
            uninstall;
            ;;
        h | *) #Print help message explaining options
            echo -e -e "Usage:
            -s : Prepares the environment (run this first if you want a specific container)
            -i : Installs all options (options -s -k -b)
            -k : Installs only Kali
            -b : Installs only blackarch
            -u : Uninstalls this tool
            -h : Display this message";
            exit 1 ;;
    esac
done