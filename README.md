## A simple pentesting setup for Fedora and pretty much wherever else you can get Podman

Previously this repo had Pentools, a script that would install a bunch of tools. This was a large list, time consuming and inefficient to maintain and use as everything was effectively built from source. In short, it's wasteful.
The script is still in this repo but now defunct and called "tools.txt".

Instead of emulating and pretending to have the same stuff as Kali. We are now going to use Kali directly via podman.
I have a few goals to be implemented here.

-   I want to re-use as much of the host stack as possible (re-use the kernel, networking stack, HDD/SSD without needing a binary only usable by a full hypervisor)
-   I want this to be there when you need it, and have minimal impact when you dont
-   Something controlable by an unpriveleged user

This will likely be rough as I have no experience with podman until this.

---

*Any suggestions please don't hesitate to contact or open an issue*

Requirements
====================
- ~An OS built around the same time as Ubuntu 18.04~ You need an x86_64 CPU and to be able to run Podman.
- disk space, Depends how much Kali you want. The image this script pulls is a base image and is just enough to boot.
- systemD, we're using system files to control it as a service
- An understanding of how to install software on the CLI as the Kali image has no tools when installed, you gotta do that yourself.

---

### how to use

- Run the install script for your platform (MacOS or Linux)
- If on Linux run:
    - `systemctl --user start container-kali`
    - `podman attach --latest` (or use the ID assigned to the container)
- If on MacOS start the container and run the attach command above

To stop the container on Linux run `systemctl --user stop container-kali`