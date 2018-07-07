#!/usr/bin/env bash
#check we are running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo, as the user you are wanting to install it for"
   exit 1
fi
# Bookmarking where the script was run from
installfolder="$PWD"
#Trying to get user's default shell -- we need to know for later
dshell="$SHELL"
mydirectory="/opt/pentools-slim"

#get to know where we are doing this on the system and as whom
echo -e "This script is a slimmed down version of pentools, it installs specific tools and is aimed at people wanting a few frameworks/tools that are not included in a regular Kali install. \n \n  we aim to provide the following: \n - Routersploit \n - Airgeddon \n - MITMF \n "
echo -e "\e[31m This script is aimed at embedded devices (i.e a raspberry pi) \e[0m "
read -p "[*]Please enter your username, this will help me fix permissions (use 'id' if unsure) : " myname
clear
echo -e "Your files will be installed to \e[35m /opt/$mydirectory \e[0m and will be usable by the user: \e[31m $myname \e[0m "
echo -e "your default shell is \e[33m $dshell \e[0m "

pre_install_setup(){  
    apt-get update -y
    apt-get dist-upgrade -y
    apt-get instal masscan nmap openvpn
}

install_routersploit(){
    echo -e "\e[31m -> \e[0m \e[32m [*]Installing Routersploit \e[0m"
    cd /opt/$mydirectory/
    sudo apt-get install git python3-pip libglib2.0-dev
    git clone https://www.github.com/threat9/routersploit
    cd routersploit
    python3 -m pip install -r requirements.txt
    python3 -m pip install bluepy
}

install_airgeddon(){
     git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git
}

install_MITMF(){
    git clone https://github.com/byt3bl33d3r/MITMf.git
    pip install BeautifulSoup4
    pip install -r requirements.txt
    pip install mysql-python
}

install_wifite(){
    git clone https://github.com/derv82/wifite.git
}

fix_perms(){
    echo -e " \e[31m -> \e[0m \e[32m [*]correcting user-rights \e[0m"
    chown -R $myname:$myname /opt/$mydirectory
}

create_symlink(){
    cd $HOME
    ln -s /opt/$mydirectory ./
}

