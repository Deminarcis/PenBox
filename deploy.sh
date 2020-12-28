echo '### Deploying helper script'
mkdir -p ~/.local/bin
cp start-kali ~/.local/bin
cp stop-kali ~/.local/bin
echo '### Pulling Pod from the internet and installing'
podman run --name Kali --net=host --privileged -e DISPLAY=:0 -it -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/podman-storage/Kali:/Shared kalilinux/kali-rolling -p 2222:22 /bin/bash
echo -e 'Setup done, start and stop scripts are set up for this user and kept in `~/.local/bin` you may wish to add the directory to your path (export PATH=$PATH:$HOME/.local/bin ) or move them somewhere else.'