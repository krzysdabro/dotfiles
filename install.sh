#!/bin/bash

C_YELLOW="\e[0;33m"
C_BLUE="\e[0;34m"
C_RESET="\e[0m"

DOTFILES=`dirname $(realpath $0)`

arrow() {
  printf "${C_YELLOW}=>${C_RESET}  $@\n"
}

link() {
  rm -rf "$2"
  ln -s "$1" "$2"
}

##################################################

install_git() {
  arrow "Git"

  link "${DOTFILES}/git" "${HOME}/.config/git"
}

install_zsh() {
  arrow "Zsh"

  link "${DOTFILES}/.zshrc" "${HOME}/.zshrc"
  link "${DOTFILES}/zsh" "${HOME}/.zsh"
}

install_nvim() {
  arrow "Neovim"

  link "${DOTFILES}/nvim/" "${HOME}/.config/nvim"
  curl -sLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_vs_code() {
  arrow "Visual Studio Code"

  if [[ "$OSTYPE" =~ ^darwin ]]; then
    CODE_PATH="${HOME}/Library/Application Support/Code/User"
  else
    CODE_PATH="${HOME}/.config/Code/User"
  fi

  link "${DOTFILES}/vscode" "${CODE_PATH}"
}

##################################################

install_git

if which zsh &> /dev/null; then
  install_zsh
fi

if which nvim &> /dev/null; then
  install_nvim
fi

if which code &> /dev/null; then
  install_vs_code
fi
