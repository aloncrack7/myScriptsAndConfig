#!/bin/bash

# Init and fonts
. ./.env
cp createVenv.sh ~
cat alias.txt >> ~/.bashrc
source ./fonts.sh
source ./addSSHkeys.sh

# Apt and snap
sudo apt install $(cat ./apt.txt)
sudo snap install $(cat ./snap.txt)

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
source ~/.fzf/install
echo 'eval "$(fzf --bash)"' >> ~/.bashrc

# FZF git
source ~/fzf-git.sh/fzf-git.sh

# Batcat
bat --list-themes | fzf --preview="batcat --theme={} --color=always ~/.bashrc"

# Delta
cat ./.gitconfig >> ~/.gitconfig

echo "Close terminal and set up the font latter run ./installzsh.sh"
