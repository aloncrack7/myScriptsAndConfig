#!/bin/bash

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
cat alias.txt >> ~/.zshrc
zsh

echo 'eval "$(fzf --zsh)"' >> ~/.zshrc
echo "zsh is installed change it as default terminal"
