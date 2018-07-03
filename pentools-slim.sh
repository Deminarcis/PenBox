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

#get to know where we are doing this on the system and as whom
read -p "[*]Please enter your username, this will help me fix permissions (use 'id' if unsure) : " myname
echo "[*]what would be your prefered directory name for the tools? the tools will be installed in /opt/nameyouchose "
read -p "[*]Please enter the directory name you would like: " mydirectory
clear
echo -e "Your files will be installed to \e[35m /opt/$mydirectory \e[0m and will be usable by the user: \e[31m $myname \e[0m "
echo -e "your default shell is \e[33m $dshell \e[0m "