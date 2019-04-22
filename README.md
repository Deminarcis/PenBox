#### Pentools

Forked from madmantm.

This is a script to install Penetration testing tools, which are useful for network auditing among other things. I dont condone the use of this script to do horrible things to horrible/not horrible people. I am not responsible for your actions , so you do you.
I put this together because I got tired of installing a VM then passing off USB devices, which can be difficult from a Laptop PC due to I/O restrictions. i have split this into an LTS and Non-LTS variant so I can target the two independently. For distros that dont use an lTS model, either script should work. the main difference is some package names will be different.

To install, clone the repo and use:
```
chmod +x pentools<variant>.sh

sudo ./pentools<variant>.sh

```

Tools are installed in /opt in a folder of your choosing with the exception of tools pulled in for Arch, they are system-wide.

Updated to include BlackArch.... just in-case you use Arch
Aimed at latest Ubuntu LTS releases, includes some use for Fedora and Ubuntu interim releases

*Any suggestions to add more tools please don't hesitate to contact or open an issue*
*This will be maintained to the best of my ability.*
*This repo purely serves as a way for me to track and make the changes for this script to work for me and my use case*

This doesn't work on Windows. I'm not even a little sorry.

Requirements
====================
- An OS built araound the same time as Ubuntu 18.04
- About 20-30gb of disk space
