mkdir -p ~/.local/bin
cp start-kali-pod ~/.local/bin
cp stop-kali-pod ~/.local/bin
podman run --name kali-pod --net=host --privileged -e DISPLAY=:0 -it -v /tmp/.X11-unix:/tmp/.X11-unix -v ~/podman-storage/Kali:/Shared kalilinux/kali-rolling /bin/bash