#!/bin/bash

# Block root execution
if [[ $EUID -eq 0 ]]; then
    echo "❌ Run as regular user: ./auto4_setup_shell.sh"
    exit 1
fi

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Clone shell configs
git clone git@github.com:ilorez/mybash.git ~/.myshells

# Configure i3 autostart
echo "exec i3" > ~/.xinitrc

# Add Xorg autostart to shell profile
cat >> ~/.zprofile <<'EOF'
if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
    exec startx
fi
EOF

# Link custom configurations
cat >> ~/.zshrc <<'EOF'
source ~/.myshells/linker
source $ALIASES_FILE
source $FUNCTIONS_FILE
source $EXPORTS_FILE
source $INTRA_FILE
alias wifi="nmtui"
EOF

echo -e "\n\033[1;32m✔ Shell configured\033[0m"

# Clone and deploy dotfiles
echo -e "\n\033[1;32m=== Configuring Dotfiles ===\033[0m"
git clone https://github.com/ilorez/mydotfiles.git ~/.dotfiles

# Create config directory if missing
mkdir -p ~/.config

# Rsync to preserve existing files
rsync -av --ignore-existing ~/.dotfiles/.config/ ~/.config/

# Optional: Symlink for future updates
ln -sf ~/.dotfiles/.config ~/linked-config 2>/dev/null

echo "✅ Dotfiles deployed to ~/.config"
echo "Run: source ~/.zshrc && ./auto5_install_nvim.sh"
