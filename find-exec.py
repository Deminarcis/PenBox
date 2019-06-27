#!/usr/bin/env python3
### Imports
import os
import platform

### Functions

def update_bashrc():
    open("~/.bashrc", "a")
    with open("~/.bashrc", "a") as bashrc:
        bashrc.write("PATH=$PATH:/home/$USER/bin")
    bashrc.close()

def update_zshrc():
    open("~/.zshrc", "a")
    with open("~/.zshrc", "a") as zshrc:
        zshrc.write("PATH=$PATH:/home/$USER/bin")
    zshrc.close()

os.system("mkdir -p /home/'$USER'/.local/bin")
#Run Chunk
os.system("read -p 'Where did you install pentools?  ' runFolder")
print("Finding executable files  in $runFolder")
#os.system("find $runFolder -type f -executable -name '*.py' -o -name '*.rb' -o -name '*.sh' -exec 'ln -s '{}' '/home/$USER/.local/bin''")
fnames = ([file for root, dirs, files in os.walk(dir)
    for file in files
    if file.endswith('.sh') or file.endswith('.py') or file.endswith('.rb') #or file.endswith('.png') or file.endswith('.pdf')
    ])
for fname in fnames: os.system("ln -s %s /home/$USER/.local/bin" % fname)
if os.access("~/.bashrc", os.R_OK):
    update_bashrc()
if os.access("~/.zshrc", os.R_OK):
    update_zshrc()