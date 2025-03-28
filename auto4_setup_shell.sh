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
echo "Run: source ~/.zshrc && ./auto5_install_nvim.sh"
