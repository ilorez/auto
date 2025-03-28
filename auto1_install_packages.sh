#!/bin/bash

# Verify root privileges
if [[ $EUID -ne 0 ]]; then
    echo "❌ Run as root: sudo ./auto1_install_packages.sh"
    exit 1
fi

# Install NetworkManager first
pacman -Sy --noconfirm networkmanager

# Enable and start NetworkManager
systemctl enable --now NetworkManager.service

# Sync repositories and install core packages
pacman -Sy --noconfirm sudo git vim zsh alacritty xclip xorg-server i3 i3status i3lock dmenu xorg-xinit gcc clang less rsync

echo -e "\n\033[1;32m✔ Base packages installed\033[0m"
echo "Proceed with: ./auto2_create_user.sh"
