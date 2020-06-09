#!/bin/bash

function update_package_manager() {
  if [ $(command -v pacman) ]; then
    sudo pacman -Sy
  fi

  if [ $(command -v apt) ]; then
    sudo apt update
  fi

  if [ $(command -v apk) ]; then
    sudo apk update
  fi
}

function install_package() {
  if [ $(command -v pacman) ]; then
    sudo pacman -S --noconfirm $1
  fi

  if [ $(command -v apt) ]; then
    sudo apt install -y $1
  fi

  if [ $(command -v apk) ]; then
    sudo apk install -y $1
  fi
}

function set_up_neovim() {
  install_package neovim
  mkdir -p $HOME/.config

  if [ -d $HOME/.config/nvim ]; then
    rm -rf $HOME/.config/nvim
  fi

  git clone git@github.com:nilsmartel/nvim nvim

  # install vim-plug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
}

update_package_manager

set_up_neovim
for p in tmux zsh fzy lolcat ripgrep shfmt; do
  install_package $p
done

# Setting up rustlang
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Set up oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cargo install exa bat
