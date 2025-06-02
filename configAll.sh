#!/bin/bash

# Change the repo origin
./changeOriginTossh.sh

# Init and fonts
. ./.env
cp createVenv.sh ~
cat alias.txt >> ~/.bashrc
git config --global alias.lol "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
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
