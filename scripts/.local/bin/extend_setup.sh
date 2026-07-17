#!/bin/bash

# debian
sudo apt update && sudo apt upgrade -y

# base-desktop-debian
sudo apt install -y \
xorg \
lightdm \
lightdm-gtk-greeter \
icewm \
rofi \
x11-xserver-utils \
fonts-noto-cjk \
pulseaudio-utils \
pipewire-audio \
pavucontrol \
dunst \
libnotify-bin \
chromium \
xclip \
pcmanfm \
flameshot

# fcitx5 # Restart Required
sudo apt -y install fcitx5 fcitx5-chinese-addons fcitx5-frontend-gtk3 fcitx5-frontend-qt5 im-config
im-config -n fcitx5

# zen
[ -d "$HOME/.tarball-installations/zen" ] || curl -fsSL https://github.com/zen-browser/updates-server/raw/refs/heads/main/install.sh | bash

# vscode
command -v code > /dev/null || { echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections && wget -O /tmp/vscode.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y /tmp/vscode.deb && rm /tmp/vscode.deb; }

# clean
sudo apt autoremove -y && sudo apt clean
