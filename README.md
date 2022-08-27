## A simple pentesting setup for Fedora and pretty much wherever else you can get Podman

Previously this repo had Pentools, a script that would install a bunch of tools. This was a large list, time consuming and inefficient to maintain and use as everything was effectively built from source. In short, it's wasteful.
The script is still in this repo but now defunct and called "tools.txt".

Instead of emulating and pretending to have the same stuff as Kali. Why not just use Kali? Or Blackarch? or Parrot (Parrot didnt go so well.....)

I have a few goals to be implemented here.

-   I want to re-use as much of the host stack as possible (re-use the kernel, networking stack, HDD/SSD without needing a binary only usable by a full hypervisor)
-   I want this to be there when you need it, gone when you dont. With minimal impact, without posioning the host
-   Something controlable by an unpriveleged user
-   Something quick and possibly ephemeral

~~This will likely be rough as I have no experience with podman until this.~~


The original implementation was rough and not great to use becasue i'm new to this. There was a lot missing and I felt like I was providing a disservice over who this was initially forked from. This tool has been rebased to leverage [the distrobox project](https://github.com/89luca89/distrobox). while mainitnain hooks into systemd


---

*Any suggestions please don't hesitate to contact or open an issue*

Requirements
====================
- ~An OS built around the same time as Ubuntu 18.04~ You need system able to run Podman. preferably somthing from the RHEL family.
- disk space, a little or a lot. Depends how much you want. The Kali image provided is a minimal install but other options may be more full featured, as is blackarch
- systemD, we're using system files to control containers as a service, the rest is handled by distrobox
- An understanding of how to install software on the CLI as the Kali images have no tools when installed, you gotta build Kali yourself, the install is very minimal.

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
    exit 1 ;;

```