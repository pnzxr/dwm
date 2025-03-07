#!/bin/bash

# Ensure the script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Please run this script as root or with sudo!"
    exit 1
fi

USER_HOME="/home/zxc"
ZSH_CUSTOM="$USER_HOME/.zsh"

# Update system and install base dependencies
echo "Updating system and installing base dependencies..."
pacman -Syu --noconfirm --needed

# Install Pacman packages
echo "Installing required packages..."
pacman -S --noconfirm --needed \
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
    p7zip aria2 xorg-server xorg-xinit xorg-xrandr  \
    xorg-xbacklight xorg-xsetroot xorg-xprop xorg-xinput \
    zsh picom ttf-jetbrains-mono ttf-jetbrains-mono-nerd \
    firefox firefox-developer-edition btop docker docker-compose \
    nodejs npm kitty discord filezilla wget curl clipmenu \
    libinput xf86-input-libinput xf86-video-intel

# Enable and start Docker service
echo "Enabling Docker service..."
systemctl enable --now docker
usermod -aG docker zxc

# Install yay (AUR helper) if not installed
if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    pacman -S --noconfirm --needed base-devel git
    sudo -u zxc git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin || exit
    sudo -u zxc makepkg -si --noconfirm
    cd ~ || exit
    rm -rf /tmp/yay-bin
fi

# Install AUR packages using yay
echo "Installing AUR packages..."
sudo -u zxc yay -S --noconfirm --needed 7zip

# Set up Zsh autosuggestions and syntax highlighting
echo "Setting up Zsh autosuggestions and syntax highlighting..."
mkdir -p "$ZSH_CUSTOM"

# Install Zsh plugins
if [ ! -d "$ZSH_CUSTOM/zsh-autosuggestions" ]; then
    sudo -u zxc git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/zsh-syntax-highlighting" ]; then
    sudo -u zxc git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/zsh-syntax-highlighting"
fi

# Create symbolic links
ln -sf "$ZSH_CUSTOM/zsh-autosuggestions/zsh-autosuggestions.zsh" "$ZSH_CUSTOM/zsh-autosuggestions.zsh"
ln -sf "$ZSH_CUSTOM/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "$ZSH_CUSTOM/zsh-syntax-highlighting.zsh"

# Set Zsh as default shell for user zxc
echo "Setting Zsh as default shell for zxc..."
chsh -s $(which zsh) zxc

echo "Installation complete! Please restart your system if needed."
