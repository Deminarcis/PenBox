#!/usr/bin/env python3
### Imports
import os
import platform

# Vars
user = input("What is your username? ")
os.system("mkdir -p /home/%s/.local/bin" % (user))
os.system("ln -s /home/%s/.local/bin /home/%s/bin" % (user, user))

### Functions

def update_bashrc():
    open("~/.bashrc", "a")
    with open("~/.bashrc", "a") as bashrc:
        bashrc.write("PATH=$PATH:/home/%s/bin" % (user))
    bashrc.close()

def update_zshrc():
    open("~/.zshrc", "a")
    with open("~/.zshrc", "a") as zshrc:
        zshrc.write("PATH=$PATH:/home/%s/bin" % (user))
    zshrc.close()

#Run Chunk
dir = '/opt/haxxx'
print("Finding executable files in /opt/haxxx")
fnames = ([file for root, dirs, files in os.walk(dir)
    for file in files
    if file.endswith('.sh') or file.endswith('.py') or file.endswith('.rb') #or file.endswith('.png') or file.endswith('.pdf')
    ])
for fname in fnames: 
    os.system("ln -s %s /home/%s/.local/bin" % (fname, user))
if os.access("~/.bashrc", os.R_OK):
    update_bashrc()
if os.access("~/.zshrc", os.R_OK):
    update_zshrc()