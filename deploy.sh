echo '### Pulling Pod from the internet and installing'
podman run -dt --name Kali --net=host --privileged -e DISPLAY=:0 -it -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/podman-storage/Kali:/Shared kalilinux/kali-rolling /bin/bash
echo -e 'Setting up systemd files'
podman generate systemd --name Kali > ~/.config/systemd/user/container-kali.service