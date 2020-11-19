## A simple pentesting setup for Fedora and hopefully CentOS/RHEL

Previously this repo had a script that would install a bunch of tools. This was large, time consuming and inefficient to maintain.
The script is still in this repo but now defunct and called "tools.txt".

Instead of emulating and pretending to have the same stuff as Kali. We are now going to use Kali directly via podman.
I have a few goals to be implemented here.

-   I want to re-use as much of the host stack as possible (re-use the display server instead of a whole new window, re-use the host netowrking and harddrive to have a minimal environtment that doesnt feel second class)
-   I want this to be there when you need it, and have minimal impact when you dont
-   Containers are kinda tricky for the uninitiated, I aim to have a few helper scripts to make things easier
-   Something controlable by an unpriveleged user

This will likely be rough as I have no experience with podman until this.

---
To install, clone the repo and use:
```
chmod +x deploy.sh

./deploy.sh

```
---

*Any suggestions please don't hesitate to contact or open an issue*
*This will be maintained to the best of my ability.*
*This repo purely serves as a way for me to track and make the changes for this script to work for me and my use case*

This doesn't work on Windows. Not even a little... Sorry.

Requirements
====================
- ~An OS built around the same time as Ubuntu 18.04~ Fedora and maybe CentOS/RHEL
- disk space, i'm not sure but lets say 100GB to be sure
