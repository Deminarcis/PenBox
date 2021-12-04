#!/usr/bin/env bash
echo "### Stopping Kali container ###"
systemctl --user stop container-kali.service 
echo "### Removing container ###"
podman rm Kali
echo "### Removing image ###"
podman rmi docker.io/kalilinux/kali-rolling:latest
echo "Kali-pod removed from system"