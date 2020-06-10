#!/usr/bin/env bash
#check we are running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run with sudo, as the user you are wanting to install it for"
   exit 1
fi
# Bookmarking where the script was run from
runFolder="$PWD"
myDirectory = "/opt/haxxx"

#Install Groups (lists for OS at the bottom)

fedora_preinstall(){
    echo -e "\e[31m -> \e[0m \e[32m [*]Making sure we have everything before we start the rest of the setup. \e[0m"
    dnf update -y
    dnf upgrade -y
    dnf remove totem rhythmbox evolution -y
    dnf install -y kernel-headers kernel-devel gcc glibc-headers rpm-build
    dnf groupinstall -y "C Development Tools and Libraries"
    dnf groupinstall -y "Development Tools"
    dnf groupinstall -y security-lab
    dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    rm rpmfusion-*
    dnf install -y nano scalpel foremost scapy srm yersinia hping3 tcpreplay tcpick socat ophcrack gdb stunnel cmake flex eog openconnect gengetopt steghide whois aircrack-ng gimp iw extundelete rpcbind rdesktop sshfs bzip2 gnome-tweak-tool libtool irssi medusa hydra hydra-frontend terminator curl proxychains perl-Image-ExifTool p7zip p7zip-plugins libpcap htop gnupg subversion git traceroute gparted pidgin pidgin-otr ghex ettercap libnetfilter_queue-devel openvpn dsniff tcpdump john nmap nbtscan wireshark java-1.8.0-openjdk vconfig reaver pyrit thc-ipv6 freerdp qemu-kvm binwalk virt-manager qemu-system-x86 gvfs-fuse autoconf postgresql pgadmin3 chromium vlc php-cli
    dnf install -y ruby ruby-devel rubygem-bundler rubygem-json rubygem-i18n ruby-irb rubygems rubygem-bigdecimal rubygem-rake rubygem-sqlite3 golang keepass
    dnf install -y python python-pip python-setuptools python-libs python-magic python-netaddr python3-netaddr python-inotify python3-configobj python2-configobj python-msgpack python-requests python-pefile pylibpcap python-dns python-cryptography python-devel python-twisted capstone-python python-urllib3 python-pillow python-beautifulsoup python-beautifulsoup4 python2-selenium python3-selenium python-impacket
    dnf install -y readline readline-devel capstone libnl3-devel capstone-devel capstone-python3 openssl openssl-devel libxml2 libxml2-devel libxslt libxslt-devel libyaml libyaml-devel libffi libffi-devel libssh libssh-devel libpqxx libpqxx-devel libsqlite3x libsqlite3x-devel libpcap libpcap-devel pcre libcurl-devel libnfnetlink libnfnetlink-devel libnetfilter_queue-devel zlib-devel zlibrary xz-devel zlibrary-devel postgresql-devel libidn libidn-devel ncurses-libs ncurses ncurses-devel libappindicator libindicator m2crypto
}

install_pips(){
    pip install mitmproxy
}

install_gems(){
    gem install snmp
    gem install pcaprub
    gem install rake
}

create_directories(){
    echo -e "\e[31m -> \e[0m \e[32m [*]create default core tools directory \e[0m"
    mkdir $myDirectory
    cd $myDirectory/
    mkdir $myDirectory/cheatsheets
    mkdir $myDirectory/network
    mkdir $myDirectory/webapps
    mkdir $myDirectory/exploits
    mkdir $myDirectory/mobile
    mkdir $myDirectory/wordlists
    mkdir $myDirectory/escalation
    mkdir $myDirectory/pwcracking
    mkdir $myDirectory/reverse
    mkdir $myDirectory/recon
    mkdir $myDirectory/wireless
    mkdir $myDirectory/windows
    mkdir $myDirectory/linux
    mkdir $myDirectory/postexploitation
    mkdir $myDirectory/social_engineering

}

install_metasploit(){
    echo -e "\e[31m -> \e[0m \e[32m [*] Gathering the metasploit repository \e[0m"
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
    chmod 755 msfinstall && \
    ./msfinstall
}

install_routersploit(){
    echo -e "\e[31m -> \e[0m \e[32m [*] Installing Routersploit \e[0m"
    cd $myDirectory/
    sudo apt-get install git python3-pip libglib2.0-dev
    git clone https://www.github.com/threat9/routersploit
    cd routersploit
    python3 -m pip install -r requirements.txt
    python3 -m pip install bluepy
}

misc_tools(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing other miscellaneous exploit tools \e[0m"
    cd $myDirectory/exploits
    git clone https://github.com/longld/peda.git
    git clone https://github.com/govolution/avet
    git clone https://github.com/g0tmi1k/exe2hex.git
    git clone https://github.com/huntergregal/mimipenguin
    git clone https://github.com/lockfale/meterpreterjank.git
    git clone https://github.com/PenturaLabs/Linux_Exploit_Suggester.git
    git clone https://github.com/vulnersCom/getsploit
    git clone https://github.com/trustedsec/unicorn
    git clone https://github.com/tokyoneon/Armor
    cd Armor
    chmod +x armor.sh
    cd $myDirectory
}

wordlists(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Gathering wordlists \e[0m"
    cd $myDirectory/wordlists
    git clone https://github.com/danielmiessler/SecLists.git
    wget -nc http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
    wget -nc http://www.tekdefense.com/downloads/wordlists/1aNormusWL.zip
    wget -nc http://www.tekdefense.com/downloads/wordlists/KippoWordlist.txt
    git clone https://github.com/digininja/CeWL.git
    cd $myDirectory
}

install_burp(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing Burpsuite \e[0m"
    cd $myDirectory/webapps
    mkdir $myDirectory/webapps/burp_proxy
    cd $myDirectory/webapps/burp_proxy
    curl https://portswigger.net/DownloadUpdate.ashx?Product=Free -o burpsuite_free.jar
    cd $myDirectory
}

misc_scripts(){
    echo -e "\e[31m -> \e[0m \e[32m [*] Gathering some extra scripts \e[0m"
    cd $myDirectory
    mkdir $myDirectory/misc
    cd $myDirectory/misc
    git clone https://github.com/ChrisTruncer/PenTestScripts.git
    cd $myDirectory
}

install_tor(){
    echo -e "\e[31m -> \e[0m \e[32m [*] Install Tor \e[0m"
    mkdir $myDirectory/network/torbrowser
    cd $myDirectory/network/torbrowser
    wget -nc https://www.torproject.org/dist/torbrowser/9.0.10/tor-browser-linux64-9.0.10_en-US.tar.xz
    tar -xf tor-browser-linux64-9.0.10_en-US.tar.xz
    rm -rf tor-browser-linux64-9.0.10_en-US.tar.xz
    cd $myDirectory
}

php_reverse(){
    echo -e "\e[31m -> \e[0m \e[32m [*] Gathering PHP reverse shell tools \e[0m"
    mkdir $myDirectory/network/reverse_shells
    cd $myDirectory/network/reverse_shells
    wget -nc http://pentestmonkey.net/tools/php-reverse-shell/php-reverse-shell-1.0.tar.gz
    tar -xf $myDirectory/network/reverse_shells/php-reverse-shell-1.0.tar.gz
    cd $myDirectory
}

privesc_tools(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing privesc tools \e[0m"
    cd $myDirectory/escalation
    git clone https://github.com/mattifestation/PowerSploit.git
    git clone https://github.com/putterpanda/mimikittenz.git
    git clone https://github.com/PowerShellEmpire/PowerTools.git
    git clone https://github.com/Kevin-Robertson/Inveigh.git
    git clone https://github.com/xan7r/kerberoast.git
    git clone https://github.com/breenmachine/RottenPotatoNG
    cd $myDirectory
}

post-exploit(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing post-exploitation tools \e[0m"
    cd $myDirectory/postexploitation
    git clone https://github.com/AlessandroZ/LaZagne.git
    git clone https://github.com/CoreSecurity/impacket.git
    pip install ldap3
    git clone https://github.com/EmpireProject/Empire.git
    cd $myDirectory
}

install_volatility(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Install the volatility framework \e[0m"
    mkdir $myDirectory/forensics
    cd $myDirectory/forensics
    git clone https://github.com/volatilityfoundation/volatility.git
    cd $myDirectory
}

recon_tools(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing other recon tools \e[0m"
    cd $myDirectory/recon
    git clone https://github.com/guelfoweb/knock.git
    git clone https://github.com/laramies/theHarvester.git
    git clone https://github.com/eth0izzle/bucket-stream
    git clone https://github.com/dmuhs/pastebin-scraper.git
    git clone https://github.com/breenmachine/httpscreenshot
    git clone https://github.com/mschwager/gitem
    git clone https://github.com/hardikvasa/google-images-download.git
    git clone https://github.com/m0rtem/CloudFail
    git clone https://github.com/laramies/metagoofil
    git clone https://github.com/TheRook/subbrute.git
    git clone https://github.com/ejcx/subdomainer.git
    git clone https://github.com/aboul3la/Sublist3r.git
    git clone https://github.com/ChrisTruncer/EyeWitness.git
    git clone https://github.com/hatRiot/clusterd.git
    git clone https://github.com/dmuhs/pastebin-scraper
    git clone https://github.com/nyxgeek/o365recon
    git clone https://github.com/darkoperator/dnsrecon.git
    git clone https://github.com/urbanadventurer/WhatWeb.git
    git clone https://github.com/leebaird/discover.git
    git clone https://github.com/Mr-Un1k0d3r/RedTeamPowershellScripts.git
    git clone https://github.com/makefu/dnsmap.git
    cd $myDirectory/recon/dnsmap
    make
    cd $myDirectory
}

install_pwcrackers(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing password cracking tools \e[0m"
    cd $myDirectory/pwcracking/
    git clone https://github.com/lanjelot/patator.git
    git clone https://github.com/mikesiegel/ews-crack
    git clone https://github.com/galkan/crowbar
    git clone https://github.com/magnumripper/JohnTheRipper.git
    cd $myDirectory/pwcracking/JohnTheRipper/src
    ./configure
    make
    cd $myDirectory
    mkdir $myDirectory/pwcracking/hashcat
    cd $myDirectory/pwcracking/hashcat
    wget https://hashcat.net/files/hashcat-4.0.1.7z
    7z x hashcat-4.0.1.7z
    mkdir $myDirectory/pwcracking/crunch
    cd $myDirectory/pwcracking/crunch
    wget -nc "http://downloads.sourceforge.net/project/crunch-wordlist/crunch-wordlist/crunch-3.6.tgz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fcrunch-wordlist%2F&ts=1473785126&use_mirror=pilotfiber" -O crunch-3.6.tgz
    cd $myDirectory/pwcracking/
    git clone https://github.com/ZerBea/hcxtools.git
    cd hcxtools
    make
    make install
    cd $myDirectory/pwcracking/
    git clone https://github.com/ZerBea/hcxdumptool.git
    cd hcxdumptool
    make
    make install
    cd $myDirectory
}

webapp_tools(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing arachni and other webapp tools \e[0m"
    cd $myDirectory/webapps
    wget http://testssl.sh/testssl.sh
    mkdir /opt/$mydirectory/webapps/arachni
    cd /opt/$mydirectory/webapps/arachni
    wget -nc https://github.com/Arachni/arachni/releases/download/v1.5.1/arachni-1.5.1-0.5.12-linux-x86_64.tar.gz
    tar -xf arachni-1.5.1-0.5.12-linux-x86_64.tar.gz
    rm arachni-1.5.1-0.5.12-linux-x86_64.tar.gz
    cd /opt/$mydirectory/webapps
    git clone https://github.com/XiphosResearch/exploits.git
    git clone https://github.com/UltimateHackers/XSStrike
    git clone https://github.com/nahamsec/JSParser.git
    git clone https://github.com/wpscanteam/wpscan.git
    git clone https://github.com/spinkham/skipfish.git
    git clone https://github.com/joaomatosf/jexboss.git
    git clone https://github.com/internetwache/GitTools.git
    git clone https://github.com/OsandaMalith/LFiFreak
    git clone https://github.com/maurosoria/dirsearch.git
    git clone https://github.com/D35m0nd142/LFISuite.git
    git clone https://github.com/P0cL4bs/Kadimus
    git clone https://github.com/stasinopoulos/commix.git
    git clone https://github.com/kost/dvcs-ripper
    git clone https://github.com/mandatoryprogrammer/xssless.git
    git clone https://github.com/tennc/fuzzdb.git
    git clone https://github.com/tennc/webshell
    git clone https://github.com/swisskyrepo/PayloadsAllTheThings
    git clone https://github.com/CaledoniaProject/AxisInvoker.git
    git clone https://github.com/vs4vijay/heartbleed.git
    git clone https://github.com/beefproject/beef
    git clone https://github.com/Dionach/CMSmap.git
    git clone https://github.com/droope/droopescan.git
    git clone https://github.com/gfoss/attacking-drupal.git
    git clone https://github.com/sullo/nikto.git
    git clone https://github.com/gabtremblay/tachyon.git
    git clone https://github.com/sqlmapproject/sqlmap.git
    git clone https://github.com/WebBreacher/tilde_enum.git
    git clone https://github.com/epinna/weevely3.git
    git clone https://github.com/eschultze/URLextractor.git
    git clone https://github.com/mazen160/struts-pwn_CVE-2017-9805
    git clone https://github.com/leonjza/wordpress-shell
    wget -nc "https://downloads.sourceforge.net/project/dirb/dirb/2.22/dirb222.tar.gz?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fdirb%2Ffiles%2F&ts=1503500072&use_mirror=astuteinternet" -O dirb222.tar.gz
    tar -xf dirb222.tar.gz
    chmod -R 755 dirb222/
    cd dirb222
    ./configure
    make
    cd /opt/$mydirectory/webapps
    wget -nc "http://downloads.sourceforge.net/project/dirbuster/DirBuster%20%28jar%20%2B%20lists%29/1.0-RC1/DirBuster-1.0-RC1.tar.bz2?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fdirbuster%2Ffiles%2FDirBuster%2520%2528jar%2520%252B%2520lists%2529%2F1.0-RC1%2F&ts=1443459199&use_mirror=iweb" -O DirBuster-1.0-RC1.tar.bz2
    bunzip2 DirBuster-1.0-RC1.tar.bz2
    tar -xf DirBuster-1.0-RC1.tar
    rm DirBuster-1.0-RC1.tar
    cd /opt/$mydirectory/webapps/weevely3
    pip install -r requirements.txt
    cd /opt/$mydirectory
}

install_mitm(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing tools for mitm/network/scada \e[0m"
    cd $myDirectory/network/
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
    cd /opt/$mydirectory
}

install_social_engineering(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing tools for social engineering \e[0m"
    cd $myDirectory/social_engineering
    git clone https://github.com/trustedsec/social-engineer-toolkit.git
    git clone https://github.com/philwantsfish/shard
    git clone https://github.com/mwrlabs/XRulez.git
    git clone https://github.com/dafthack/MailSniper.git
    git clone https://github.com/ustayready/CredSniper
    git clone https://github.com/khast3x/h8mail.git
    cd h8mail
    pip3 install -r requirements.txt
    cd $myDirectory
    wget -nc https://github.com/gophish/gophish/releases/download/v0.7.1/gophish-v0.7.1-linux-64bit.zip
    cd $myDirectory
}

reverse_engineering(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing tools for reverse engineering \e[0m"
    cd $myDirectory/reverse/
    git clone https://github.com/Gallopsled/pwntools.git
    git clone https://github.com/hasherezade/shellconv.git
    git clone https://github.com/botherder/viper.git
    wget -nc "https://github.com/java-decompiler/jd-gui/releases/download/v1.4.0/jd-gui-1.4.0.jar"
    git clone https://github.com/mirror/firmware-mod-kit.git
    cd $myDirectory
}

exploits(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing exploit related tools \e[0m"
    cd $myDirectory/exploits
    git clone https://github.com/offensive-security/exploit-database
    git clone https://github.com/toolswatch/vFeed.git
    git clone https://github.com/secretsquirrel/the-backdoor-factory
    git clone https://github.com/FuzzySecurity/PowerShell-Suite.git
    git clone https://github.com/peewpw/Invoke-PSImage
    git clone https://github.com/madmantm/powershell
    wget --header="Accept: text/html" --user-agent="MOZILLA" https://www.shellterproject.com/Downloads/Shellter/Latest/shellter.zip
    cd $myDirectory
}

privacy_escalation(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing tools for privelege escalation \e[0m"
    cd $myDirectory/escalation
    git clone https://github.com/samratashok/nishang.git
    git clone https://github.com/rebootuser/LinEnum.git
    git clone https://github.com/huntergregal/mimipenguin.git
    mkdir $myDirectory/escalation/mimikatz
    cd $myDirectory/escalation/mimikatz
    wget -nc http://blog.gentilkiwi.com/downloads/mimikatz_trunk.zip
    unzip -o  mimikatz_trunk.zip
    rm -rf mimikatz_trunk.zip
    cd $myDirectory
}

veil_framework(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing the veil framework \e[0m"
    cd $myDirectory/exploits
    git clone https://github.com/Veil-Framework/Veil-Evasion.git
    git clone https://github.com/Veil-Framework/Veil-PowerView.git
}

tool_cheatsheets(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Gathering cheatsheets \e[0m"
    cd $myDirectory/cheatsheets
    git clone https://github.com/HarmJ0y/CheatSheets
    git clone https://github.com/aramosf/sqlmap-cheatsheet.git
    git clone https://github.com/wsargent/docker-cheat-sheet.git
    git clone https://github.com/paragonie/awesome-appsec.git
    git clone https://github.com/enaqx/awesome-pentest
    git clone https://github.com/GrrrDog/Java-Deserialization-Cheat-Sheet
    git clone https://github.com/bluscreenofjeff/Red-Team-Infrastructure-Wiki
    cd $myDirectory
}

hash_identifiers(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing tools to identify hashes \e[0m"
    mkdir $myDirectory/crypto
    cd $myDirectory/crypto
    git clone https://github.com/SmeegeSec/HashTag.git
    cd HashTag
    chmod +x Hashtag.py
    cd ..
    git clone https://github.com/psypanda/hashID.git
    cd $myDirectory
}

wireless_tools(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing wireless et wps tools \e[0m"
    cd $myDirectory/wireless
    git clone https://github.com/DanMcInerney/wifijammer.git
    git clone https://github.com/derv82/wifite2.git
    git clone https://github.com/bitbrute/evillimiter.git
    git clone https://github.com/OpenSecurityResearch/hostapd-wpe.git
    git clone https://github.com/sophron/wifiphisher.git
    git clone https://github.com/s0lst1c3/eaphammer.git
    git clone https://github.com/Tylous/SniffAir.git
    git clone https://github.com/tehw0lf/airbash.git
    git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git
    cd wifite2
    python setup.py install
    cd $myDirectory
    cd evillimiter
    python3 setup.py install
    cd $myDirectory
}

wpscan(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing requirements for wpscan \e[0m"
    cd $myDirectory/webapps/wpscan
    bundle install
    cd $myDirectory
}


windows_tools_offline(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing Windows tools just in case no internets / also might be flagged by pesky webfiltering systems \e[0m"
    mkdir $myDirectory/windows/win_tools
    cd $myDirectory/windows/win_tools
    wget -nc "http://www.oxid.it/downloads/ca_setup.exe"
    wget -nc "http://sniff.su/Intercepter-NG.v1.0.zip"
    wget -nc "http://downloads.metasploit.com/data/releases/metasploit-latest-windows-installer.exe"
    wget -nc "http://www.ollydbg.de/odbg200.zip"
    wget -nc "http://www.ollydbg.de/odbg110.zip"
    wget -nc "https://out7.hex-rays.com/files/idafree70_windows.exe"
    wget -nc "https://download.sysinternals.com/files/SysinternalsSuite.zip"
    wget -nc "https://download.sysinternals.com/files/PSTools.zip"
    wget -nc "https://download.sysinternals.com/files/Procdump.zip"
}

linux_tools_offline(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Installing linux tools just in case no internets \e[0m"
    mkdir $myDirectory/linux/lin_tools
    cd $myDirectory/linux/lin_tools
    wget -nc "http://downloads.metasploit.com/data/releases/metasploit-latest-linux-x64-installer.run"
    wget -nc "https://out7.hex-rays.com/files/idafree70_linux.run"
}

fix_perms(){
    echo -e " \e[31m -> \e[0m \e[32m [*] Correcting permissions \e[0m"
    chown -R $myname:$myname $myDirectory
}

create_symlink(){
    cd $HOME
    ln -s $myDirectory ./
}


echo -e "
    \e[31m
        !-------------------------------------!  PENTOOLS  !----------------------------------------!


                Welcome to Pentools. This script installs penetration testing tools on regular
                Fedora, it might work elsewhere but I dont know.
                There are select Windows tools in this script but in terms of general use, this
                script will not work on Windows. This Script is not something that is designed
                to replace a dedicated security or pentesting distro but aiming to compliment the
                tools where other restrictions may be placed on what can be deployed in certain
                situations. This may also be helpful for people using Linux as a host and who dont
                want to use a VM for CTF or HackTheBox.
                Where possible I recommedn preferring BlackArch, Kali or Parrot as they
                are designed to be used for penetration testing and provide many advantages
                over this script. Please proceed with caution, If this breaks your install I
                am not repsonisble and you get to keep the pieces. If per chance this does
                break things, please open an issue on the github repo this script came from.


                                \e[33m            HAPPY HACKING!    \e[0m  \e[31m


                            The installation process will start in 30 seconds
                            If you've changed your mind, press "Ctrl + C" now


        !-------------------------------------!  PENTOOLS  !----------------------------------------!

    \e[0m
  "
sleep 30

echo -e " \e[34m INSTALLER STARTING NOW! \e[0m"

sleep 5

## Fedora Install 32+
if cat /etc/fedora-release | grep 3*
then
    Fedora="y"

#get to know where we are doing this on the system and as whom
read -p "[*] Please enter your username, this will help me fix permissions later ( run 'id' in another terminal if unsure ): " myname

if [[ -d $myDirectory/ ]]; then
    read -p "This script has been run before and can run as an updater script. Do you want to run the updater? " update
fi

clear
echo -e "Your files will be installed to \e[35m $myDirectory \e[0m and will be usable by the user: \e[31m $myname \e[0m "


if [[ "$update" == "y" ]]
then
    run_updater
    exit
fi

#Execute tailored installs based on Distro detected

if [[ "$Fedora" == "y" ]]
then
    fedora_preinstall
    install_gems
    create_directories
    install_metasploit
    misc_tools
    wordlists
    install_burp
    misc_scripts
    install_tor
    php_reverse
    privesc_tools
    post-exploit
    install_volatility
    recon_tools
    install_pwcrackers
    webapp_tools
    install_mitm
    install_social_engineering
    reverse_engineering
    exploits
    privacy_escalation
    veil_framework
    tool_cheatsheets
    hash_identifiers
    wireless_tools
    wpscan
    linux_tools_offline
    fix_perms
    create_symlink
fi

#find-exec is broken, disabling for now
#echo -e " \e[31m -> \e[0m \e[32m [*] Setting up symlinks in your rc file(s) to make this easier to use \e[0m"
#./find-exec.py
