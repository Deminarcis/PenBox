## A simple pentesting setup for Fedora and pretty much wherever else you cna get Podman

Previously this repo had Pentools, a script that would install a bunch of tools. This was a large list, time consuming and inefficient to maintain and use as everything was effectively built from source. In short, it's wasteful.
The script is still in this repo but now defunct and called "tools.txt".

Instead of emulating and pretending to have the same stuff as Kali. We are now going to use Kali directly via podman.
I have a few goals to be implemented here.

-   I want to re-use as much of the host stack as possible (re-use the kernel, networking stack, HDD/SSD without needing a binary only usable by a full hypervisor)
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

Requirements
====================
- ~An OS built around the same time as Ubuntu 18.04~ Fedora or OpenSUSE is recommended. This should work anywhere Podman installs
- disk space, Depends how muc Kali you want. The image this script pulls is a base image and is just enough to boot.
- An understanding of how to install software on the CLI as the Kali image has no tools when installed, you gotta do that yourself.
