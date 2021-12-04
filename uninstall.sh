#!/usr/bin/env bash
echo "### Stopping Kali container ###"
podman stop Kali
systemctl --user stop container-kali.service 
echo "### Container stopped ###"
echo "### Removing container ###"
podman rm Kali
echo "### Removing image ###"
podman rmi docker.io/kalilinux/kali-rolling:latest
echo "Kali-pod removed from system"