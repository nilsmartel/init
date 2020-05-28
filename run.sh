#!/bin/bash

function update_package_manager() {
    sudo pacman -Sy
}

function install_package() {
    sudo pacman -S --noconfirm $1
}

for p in neovim tmux zsh fzy lolcat
do
    install_package $p
done

# Setting up rustlang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Set up oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
