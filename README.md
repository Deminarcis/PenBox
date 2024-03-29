# PENBOX
## A simple pentesting setup built for Fedora and should work pretty much wherever else you can get Podman

Previously this repo had Pentools, a script that would install a bunch of tools. This was a large list, time consuming and inefficient to maintain and use as everything was effectively built from source. In short, it's wasteful and took way too long to provision.
The script is still in this repo but now defunct and called "tools.txt".
I have settled on a new name PenBox.... we're still doing what pentools did, just putting it in it's own box

Instead of emulating and pretending to have the same stuff as Kali. Why not just use Kali? Or Blackarch? or Parrot (Parrot didnt go so well.....)
Thanks to containers we can do exactly that
I have a few goals to be implemented here.

-   I want to re-use as much of the host stack as possible (re-use the kernel, networking stack, HDD/SSD without needing a binary only usable by a full hypervisor)
-   I want this to be there when you need it, gone when you dont. With minimal impact, without posioning the host
-   Something controlable by an unpriveleged user
-   Something quick and possibly ephemeral

~~This will likely be rough as I have no experience with podman until this.~~


The original implementation was rough and not great to use because i'm new to this. There was a lot missing and I felt like I was providing a disservice over who this was initially forked from. This tool has been rebased to leverage [the distrobox project](https://github.com/89luca89/distrobox). while maintaining it's initial goals


---

*Any suggestions please don't hesitate to contact or open an issue*

Requirements
====================
- ~An OS built around the same time as Ubuntu 18.04~ You need system able to run Podman. preferably something from the RHEL family.
- disk space, a little or a lot. Depends how much you want. The images downloaded in the default options are minimal installs
- systemD, we're using system files to control containers as a service, the rest is handled by distrobox
- An understanding of how to install software on a command prompt.

---

### How to use

run the installer from a terminal using `./install.sh` the arguments for the script are below

```
    -s : Prepares the environment (run this first if you want a specific container)
    -i : Installs all options (options -s -k -b)
    -k : Installs only Kali
    -b : Installs only blackarch
    -u : Uninstalls this tool
    -h : Display this message";

```