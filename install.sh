#!/bin/bash
set -euo pipefail

C_GREEN="\e[0;32m"
C_BLUE="\e[0;34m"
C_BOLD="\e[1m"
C_RESET="\e[0m"

arrow() {
  printf "${C_BOLD}${C_BLUE}==>${C_RESET} ${C_BOLD}$@${C_RESET}\n"
}

installing_dotfiles() {
  printf "Installing dotfiles for ${C_GREEN}$@${C_RESET}\n"
}

realpath() {
  [[ $1 == /* ]] && echo "$1" || echo "${PWD}/${1#./}"
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
  if [[ -d /Applications/$1 || -d ${HOME}/Applications/$1 ]]; then
    return 0
  fi
  return 1
}

DOTFILES=`dirname $(realpath "$0")`

# Check if script runs on MacOS
if [[ "${OSTYPE}" =~ ^darwin ]]; then
  IS_DARWIN=1
fi

# Check if script runs on ARM architecture
if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
  IS_ARM=1
fi

#########################
# Setup install functions
#########################
install_git() {
  installing_dotfiles "Git"

  link "${DOTFILES}/git" "${HOME}/.config/git"
}

install_zsh() {
  installing_dotfiles "Zsh"

  link "${DOTFILES}/.zshrc" "${HOME}/.zshrc"
  link "${DOTFILES}/zsh" "${HOME}/.zsh"
}

install_nvim() {
  installing_dotfiles "Neovim"

  link "${DOTFILES}/nvim" "${HOME}/.config/nvim"

  if [[ ! -d "${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim" ]]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim"
  fi
}

install_vs_code() {
  installing_dotfiles "Visual Studio Code"

  if [[ -n "${IS_DARWIN-}" ]]; then
    CODE_PATH="${HOME}/Library/Application Support/Code/User"
  else
    CODE_PATH="${HOME}/.config/Code/User"
  fi
  link "${DOTFILES}/vscode" "${CODE_PATH}"

  while read extid; do
    code --install-extension $extid > /dev/null
  done < ${DOTFILES}/vscode/extensions.txt
}

install_iterm() {
  installing_dotfiles "iTerm"

  link "${DOTFILES}/iTerm2.plist" "${HOME}/.config/iTerm2/com.googlecode.iterm2.plist"
}

install_aws() {
  installing_dotfiles "AWS CLI"

  link "${DOTFILES}/aws" "${HOME}/.aws"
}

########################################
# MacOS specific operations
########################################
if [[ -n "${IS_DARWIN-}" ]]; then
  arrow "Install updates and developer tools"
  sudo softwareupdate -ia
  [[ ! -d /Library/Developer/CommandLineTools ]] && xcode-select --install
  [[ -n "${IS_ARM-}" && ! -d /usr/libexec/rosetta ]] && sudo softwareupdate --install-rosetta

  [[ -n "${IS_ARM-}" ]] && export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
  if ! is_installed brew; then
    arrow "Install homebrew"
    bash -c "$(curl -fsSl https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  arrow "Run homebrew"
  brew bundle --file=${DOTFILES}/Brewfile

  # https://support.1password.com/could-not-connect/#for-all-browsers
  GOOGLE_APP_SUPPORT="${HOME}/Library/Application Support/Google"
  mkdir -p "${GOOGLE_APP_SUPPORT}/Chrome/NativeMessagingHosts" "${GOOGLE_APP_SUPPORT}/Chrome Dev/"
  link "${GOOGLE_APP_SUPPORT}/Chrome/NativeMessagingHosts" "${GOOGLE_APP_SUPPORT}/Chrome Dev/NativeMessagingHosts"

  arrow "Install MacOS settings"
  ${DOTFILES}/macos.sh
fi


##################
# Install dotfiles
##################
arrow "Install dotfiles"

is_installed git && install_git
is_installed zsh && install_zsh
is_installed nvim && install_nvim
is_installed code && install_vs_code
is_installed iTerm.app && install_iterm
is_installed aws && install_aws
