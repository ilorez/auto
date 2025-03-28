#!/bin/bash

# Block root execution
if [[ $EUID -eq 0 ]]; then
    echo "❌ Run as regular user: ./auto5_install_nvim.sh"
    exit 1
fi

# Install Neovim stack
sudo pacman -Sy --noconfirm nvim nodejs npm unzip

# Clone config
git clone git@github.com:ilorez/nvim_setup.git ~/.config/nvim

# Final message
echo -e "\n\033[1;32m✔ Setup complete!\033[0m"
echo "First nvim run will install plugins"
echo "Recommended: sudo pacman -Syu"
