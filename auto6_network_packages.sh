#!/bin/bash

# Block root execution
if [[ $EUID -eq 0 ]]; then
    echo "❌ Run as regular user: ./auto6_network_packages.sh"
    exit 1
fi

# Verify NetworkManager is running
if ! systemctl is-active --quiet NetworkManager; then
    echo "⚠️ Starting NetworkManager..."
    sudo systemctl start NetworkManager
    sudo systemctl enable NetworkManager
fi

# Get active connection name
CONN_NAME=$(nmcli -t -f NAME con show --active | head -n1)

# Configure DNS permanently
echo -e "\n\033[1;32m=== Configuring DNS for $CONN_NAME ===\033[0m"
sudo nmcli con mod "$CONN_NAME" ipv4.dns "8.8.8.8 1.1.1.1"
sudo nmcli con down "$CONN_NAME"
sudo nmcli con up "$CONN_NAME"

# Install Go and yay
echo -e "\n\033[1;32m=== Installing Development Tools ===\033[0m"
sudo pacman -Sy --noconfirm go

echo -e "\n\033[1;32m=== Installing yay AUR Helper ===\033[0m"
sudo pacman -Sy --noconfirm --needed git base-devel
git clone https://aur.archlinux.org/yay.git ~/yay-tmp
cd ~/yay-tmp && makepkg -si --noconfirm
cd ~ && rm -rf ~/yay-tmp

echo -e "\n\033[1;32m✔ Network and AUR setup complete\033[0m"
