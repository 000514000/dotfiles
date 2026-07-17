#!/bin/bash

# debian
sudo apt update && sudo apt upgrade -y

# basic-debian
sudo apt install -y \
  git \
  curl \
  wget \
  unzip \
  fzf \
  pass \
  pass-otp \
  stow \
  gnupg \
  ripgrep \
  mpv \
  mpc \
  7zip \
  starship \
  eza \
  jq \
  pandoc \
  btop \
  nodejs \
  npm \
  bat \
  network-manager \
  molly-guard \
  pwgen \
  oathtool

# vim
sudo apt install -y vim-gtk3 && mkdir -p ~/.vim/pack/min/start && [ ! -d ~/.vim/pack/min/start/fzf ] && git clone --depth 1 https://github.com/junegunn/fzf ~/.vim/pack/min/start/fzf

mkdir -p ~/.vim/pack/plugins/start
[ -d ~/.vim/pack/plugins/start/vim-oscyank/.git ] || git clone --depth=1 https://github.com/ojroques/vim-oscyank.git ~/.vim/pack/plugins/start/vim-oscyank

# fish
sudo apt install -y fish && sudo chsh -s "$(which fish)" "$USER"

# bat
command -v bat > /dev/null || sudo ln -sf /usr/bin/batcat /usr/local/bin/bat

# repomix
command -v repomix > /dev/null || sudo npm install -g repomix

# gh cli
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

# zz
mkdir -p ~/.local/bin
command -v zz > /dev/null || wget -O ~/.local/bin/zz https://github.com/TSK-io/zz_translator/releases/download/v0.1.4/zz
chmod +x ~/.local/bin/zz

# caln
command -v caln > /dev/null || { wget -O /tmp/caln.deb "https://github.com/free514dom/calendar-cli/releases/download/v0.1.9/caln_0.1.9_amd64.deb" && sudo apt install -y /tmp/caln.deb && rm /tmp/caln.deb; }

# Cattle
sudo sh -c 'cat > /etc/polkit-1/rules.d/00-nopasswd.rules << "EOF"
polkit.addRule(function(action, subject) {
    return polkit.Result.YES;
});
EOF'
sudo systemctl restart polkit

echo "ALL ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-nopasswd-all
sudo chmod 0440 /etc/sudoers.d/99-nopasswd-all

# clean
sudo apt autoremove -y && sudo apt clean
