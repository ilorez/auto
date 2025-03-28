# Arch Linux Auto-Setup

Automated setup scripts for Arch Linux environments (physical/virtual). Quickly configure your system with i3, Zsh, Neovim, and development tools.

**Repo URL**:  
https://github.com/ilorez/auto.git

## 📦 Features
- i3 Window Manager configuration
- Oh My Zsh with custom plugins/aliases
- Neovim IDE setup with plugins
- Git/SSH configuration
- User management

## ⚙️ Dotfiles Management
- Automatic deployment of:
  - i3 window manager config
  - i3status configuration
  - Alacritty terminal settings
- Future-proof structure for additional configs
- Preserves existing files during setup

## 🚀 Bootstrap Installation

### On Fresh Arch System (No Git Available)
1. **As root**, run these commands to install dependencies and fetch the repo:
```bash
pacman -Sy --noconfirm curl unzip && \
curl -L https://github.com/ilorez/auto/archive/refs/heads/main.zip -o autosetup.zip && \
unzip autosetup.zip -d /root/ && mv /root/auto-main /root/auto-setup && \
chmod +x /root/auto-setup/auth*.sh
```

2. **Run the setup sequence**:
```bash
cd /root/auto-setup
sudo ./auth1_install_packages.sh      # Base packages
sudo ./auth2_create_user.sh           # Create user
su - ilorez                           # Switch to new user
cd /root/auto-setup
./auth3_setup_git.sh                  # Git & SSH
./auth4_setup_shell.sh                # Zsh & i3
./auth5_install_nvim.sh               # Neovim
```

## 🛠️ Script Overview

| Script | Purpose | Run As |
|--------|---------|--------|
| `auth1_install_packages.sh` | Install core system packages | root |
| `auth2_create_user.sh`       | Create user & configure sudo | root |
| `auth3_setup_git.sh`         | Configure Git & SSH keys | user |
| `auth4_setup_shell.sh`       | Install Zsh & i3 config | user |
| `auth5_install_nvim.sh`      | Neovim IDE setup | user |

## 🔄 For Existing Setups (With Git)
```bash
git clone https://github.com/ilorez/auto.git
cd auto
chmod +x auth*.sh
# Follow installation sequence above
```

## ⚠️ Important Notes
1. Internet connection required during setup
2. After complete setup:  
   `sudo pacman -Syu` (update system)
3. First Neovim launch will auto-install plugins
4. SSH key generated in `auth3` needs manual GitHub addition

## 🖥️ Post-Install
- Start i3: `startx`
- Configure wifi: `wifi` alias (runs nmtui)
## 🔄 Updating Dotfiles
```bash
cd ~/.dotfiles
git pull
rsync -av --update --ignore-existing .config/ ~/.config/
```
