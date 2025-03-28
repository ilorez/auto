#!/bin/bash

# Verify root privileges
if [[ $EUID -ne 0 ]]; then
    echo "❌ Run as root: sudo ./auto2_create_user.sh"
    exit 1
fi

# Create user with home directory
useradd -m -G wheel ilorez

# Configure sudo access
echo -e "\n\033[1;33m=== Enable wheel group in sudoers ==="
echo "Uncomment: %wheel ALL=(ALL) ALL"
echo "Press Enter to open visudo..."
read
EDITOR=vim visudo

# Post-install instructions
echo -e "\n\033[1;32m✔ User 'ilorez' created\033[0m"
echo "Switch user: su - ilorez"
echo "Then run: ./auto3_setup_git.sh"
