#!/usr/bin/env bash
#check we are running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo, as the user you are wanting to install it for"
   exit 1
fi
# Bookmarking where the script was run from
runFolder="$PWD"
#Trying to get user's default shell -- we need to know for later
dshell="$SHELL"
mydirectory="/opt/pentools"

#get to know where we are doing this on the system and as whom
echo -e "This script is a slimmed down version of pentools, it installs specific tools and is aimed at people wanting a few frameworks/tools that are not included in a regular Kali install. \n \n  This script aims to provide the following: \n - Routersploit \n - Airgeddon \n - MITMF \n as well as Pumpkin Wifi"
echo -e "\e[31m This script is aimed at embedded devices (i.e a raspberry pi) \e[0m "
read -p "[*]Please enter your username, this will help me fix permissions (use 'id' if unsure) : " myname
clear
echo -e "Your files will be installed to \e[35m $mydirectory \e[0m and will be usable by the user: \e[31m $myname \e[0m "
echo -e "your default shell is \e[33m $dshell \e[0m "

pre_install_setup(){
    apt-get update -y
    apt-get dist-upgrade -y
    apt-get install masscan nmap openvpn
}

install_routersploit(){
    echo -e "\e[31m -> \e[0m \e[32m [*]Installing Routersploit \e[0m"
    cd $mydirectory/
    sudo apt-get install git python3-pip libglib2.0-dev
    git clone https://www.github.com/threat9/routersploit
    cd routersploit
    python3 -m pip install -r requirements.txt
    python3 -m pip install bluepy
}


install_MITMF(){
    echo -e "\e[31m -> \e[0m \e[32m [*]Installing Man In The Middle Framework \e[0m"
    cd $mydirectory/
    git clone https://github.com/byt3bl33d3r/MITMf.git
    pip install BeautifulSoup4
    pip install -r requirements.txt
    pip install mysql-python
}

wireless_tools(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing wireless et wps tools \e[0m"
    cd /opt/$mydirectory/wireless
    git clone https://github.com/DanMcInerney/wifijammer.git
    git clone https://github.com/derv82/wifite.git
    git clone https://github.com/OpenSecurityResearch/hostapd-wpe.git
    git clone https://github.com/sophron/wifiphisher.git
    git clone https://github.com/s0lst1c3/eaphammer.git
    git clone https://github.com/Tylous/SniffAir.git
    git clone https://github.com/tehw0lf/airbash.git
    git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git
    cd /opt/$mydirectory
}

hash_identifiers(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing tools to identify hashes \e[0m"
    mkdir /opt/$mydirectory/crypto
    cd /opt/$mydirectory/crypto
    git clone https://github.com/SmeegeSec/HashTag.git
    cd HashTag
    chmod +x Hashtag.py
    cd ..
    git clone https://github.com/psypanda/hashID.git
    cd /opt/$mydirectory
}

install_mitm(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing tools for mitm/network/scada \e[0m"
    cd /opt/$mydirectory/network/
    wget https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/vulners.nse -O /usr/share/nmap/scripts/vulners.nse
    git clone https://github.com/scadastrangelove/SCADAPASS.git
    git clone https://github.com/SySS-Research/Seth
    git clone https://github.com/DanMcInerney/icebreaker.git
    git clone https://github.com/byt3bl33d3r/DeathStar.git
    git clone https://github.com/DanMcInerney/creds.py.git
    git clone https://github.com/inquisb/keimpx
    git clone https://github.com/mlazarov/ddos-stress.git
    git clone https://github.com/sensepost/DET.git
    git clone https://github.com/DanMcInerney/LANs.py.git
    git clone https://github.com/lgandx/Responder
    git clone https://github.com/tintinweb/striptls
    git clone https://github.com/arthepsy/ssh-audit.git
    git clone https://github.com/DanMcInerney/net-creds.git
    git clone https://github.com/covertcodes/multitun.git
    git clone https://github.com/byt3bl33d3r/MITMf.git
    git clone https://github.com/byt3bl33d3r/CrackMapExec.git
    git clone https://github.com/nccgroup/redsnarf
    git clone https://github.com/m57/ARDT.git
    git clone https://github.com/vanhauser-thc/thc-ipv6.git
    git clone https://github.com/nccgroup/vlan-hopping.git
    git clone https://github.com/Hood3dRob1n/Reverser.git
    git clone https://github.com/SpiderLabs/ikeforce.git
    go get github.com/bettercap/bettercap
    mv /home/$myname/go /opt/$mydirectory/network/bettercap
    git clone https://github.com/robertdavidgraham/masscan.git
    cd /opt/$mydirectory/network/masscan/bin
    make
    cd /opt/$mydirectory/network/MITMf
    pip install BeautifulSoup4
    pip install -r requirements.txt
    pip install mysql-python
    cd /opt/$mydirectory/network/MITMf/libs/bdfactory/
    git clone https://github.com/secretsquirrel/the-backdoor-factory.git .
    cd /opt/$mydirectory/network/CrackMapExec
    pip install -r requirements.txt
    python setup.py install
    cd /opt/$mydirectory/network
    git clone https://github.com/P0cL4bs/WiFi-Pumpkin.git
    pip install service_identity
    pip install scapy_http
}

fix_perms(){
    echo -e " \e[31m -> \e[0m \e[32m [*]Fixing permissions for install directory \e[0m"
    chown -R $myname:$myname $mydirectory
}

create_symlink(){
    echo -e "\e[31m -> \e[0m \e[32m [*]Making a shortcut in your home folder ({$HOME}) \e[0m"
    cd $HOME
    ln -s $mydirectory ./
}

post-exploit(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing post-exploitation tools \e[0m"
    cd /opt/$mydirectory/postexploitation
    git clone https://github.com/AlessandroZ/LaZagne.git
    git clone https://github.com/CoreSecurity/impacket.git
    pip install ldap3
    git clone https://github.com/EmpireProject/Empire.git
    cd /opt/$mydirectory
}

wifi_pumpkin(){
    cd /opt/$mydirectory/network
    git clone https://github.com/P0cL4bs/WiFi-Pumpkin.git
    pip install service_identity
    pip install scapy_http
    cd WiFi-Pumpkin
    chmod +x installer.sh
    ./installer.sh --install
    cd /opt/$mydirectory
}

# Run functions here

pre_install_setup
post-exploit
install_mitm
hash_identifiers
wireless_tools
install_routersploit
wifi_pumpkin
fix_perms
create_symlink
