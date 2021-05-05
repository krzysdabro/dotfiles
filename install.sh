#!/bin/bash
set -euo pipefail

C_YELLOW="\e[0;33m"
C_BLUE="\e[0;34m"
C_RESET="\e[0m"

DOTFILES=`dirname $(realpath $0)`

arrow() {
  printf "${C_YELLOW}=>${C_RESET}  $@\n"
}

link() {
  rm -rf "$2"
  mkdir -p "$(dirname "$2")"
  ln -s "$1" "$2"
}

is_installed() {
  if which $1 &> /dev/null; then
    return 0
  fi
  return 1
}

#########################
# Setup install functions
#########################
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

  link "${DOTFILES}/nvim" "${HOME}/.config/nvim"
  curl -sLo "${HOME}/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
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

  while read extid; do
    code --install-extension $extid > /dev/null
  done < ${DOTFILES}/vscode/extensions.txt
}

########################################
# Updating software and installing XCode
########################################
if [[ "$OSTYPE" =~ ^darwin ]]; then
  sudo softwareupdate -ia
  xcode-select --install
  ${DOTFILES}/macos.sh
fi


##################
# Install dotfiles
##################
is_installed git && install_git
is_installed zsh && install_zsh
is_installed nvim && install_nvim
is_installed code && install_vs_code
