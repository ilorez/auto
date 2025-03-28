#!/bin/bash

# Block root execution
if [[ $EUID -eq 0 ]]; then
    echo "❌ Run as regular user: ./auto3_setup_git.sh"
    exit 1
fi

# Configure Git identity
git config --global user.name "ilorez"
git config --global user.email "zobirnajdaoui@gmail.com"

# Generate SSH key
ssh-keygen -t ed25519 -f ~/.ssh/github_key -N ""

# Display public key
echo -e "\n\033[1;32m=== Add this key to GitHub ===\033[0m"
cat ~/.ssh/github_key.pub
echo -e "\n\033[1;33mAfter adding key, run: ./auto4_setup_shell.sh\033[0m"
