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

ask() {
  read -p "$1 [y/N] " response
  [[ "$response" =~ ^[yY]$ ]] && return 0 || return 1
}

realpath() {
  [[ $1 == /* ]] && echo "$1" || echo "${PWD}/${1#./}"
}

link() {
  if [[ `dirname "$2"` =~ ^/usr ]]; then
    sudo rm -rf "$2"
    sudo mkdir -p "$(dirname "$2")"
    sudo ln -s "$1" "$2"
  else
    rm -rf "$2"
    mkdir -p "$(dirname "$2")"
    ln -s "$1" "$2"
  fi
}

is_installed() {
  return $(which "$1" &> /dev/null || [[ -d "/Applications/$1.app" || -d "${HOME}/Applications/$1.app" ]])
}

DOTFILES="${HOME}/dotfiles"


# Check if script runs on MacOS
if [[ "${OSTYPE}" =~ ^darwin ]]; then
  IS_DARWIN=1
fi

# Check if script runs on ARM architecture
if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
  IS_ARM=1
fi


########################################
# Download dotfiles repository
########################################
if [[ ! -d "${DOTFILES}" ]]; then
  arrow "Cloning dotfiles repository"
  git clone https://github.com/krzysdabro/dotfiles.git "${DOTFILES}"
fi


########################################
# MacOS specific operations
########################################
if [[ -n "${IS_DARWIN-}" ]]; then
  arrow "Update OS and install developer tools"
  ask "Do you want to install OS updates?" && sudo softwareupdate -ia --agree-to-license
  [[ ! -d /Library/Developer/CommandLineTools ]] && ask "Do you want to developer tools?" && xcode-select --install
  [[ -n "${IS_ARM-}" && ! -d /usr/libexec/rosetta ]] && ask "Do you want to install Rosetta?" && sudo softwareupdate --install-rosetta --agree-to-license

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
}

install_iterm() {
  installing_dotfiles "iTerm"

  link "${DOTFILES}/iTerm2.plist" "${HOME}/.config/iTerm2/com.googlecode.iterm2.plist"
}

install_aws() {
  installing_dotfiles "AWS CLI"

  link "${DOTFILES}/aws" "${HOME}/.aws"
}

install_npm() {
  installing_dotfiles "NPM"

  link "${DOTFILES}/.npmrc" "${HOME}/.npmrc"
}

install_pip() {
  installing_dotfiles "PIP"

  link "${DOTFILES}/pip.conf" "${HOME}/.config/pip/pip.conf"
}

install_claude() {
  installing_dotfiles "Claude Code"

  link "${DOTFILES}/claude" "${HOME}/.claude"
  link "${DOTFILES}/claude/start.sh" "/usr/local/bin/claude-start"

  if [[ ! -f "${DOTFILES}/claude/op-env-id" ]]; then
    read -p "Provide 1Password environment ID: " openv
    echo $openv > "${DOTFILES}/claude/op-env-id"
  fi

  claude_settings_files=(${DOTFILES}/claude/settings.all.json)
  if [[ -f "${DOTFILES}/claude/settings.$(hostname -s).json" ]]; then
    claude_settings_files+=(${DOTFILES}/claude/settings.$(hostname -s).json)
  fi

  claude_settings_new=$(mktemp)
  jq -s 'reduce .[] as $obj ({}; . * $obj)' ${claude_settings_files[*]} > $claude_settings_new

  if [[ -f "${DOTFILES}/claude/settings.json" ]]; then
    claude_settings_current="${DOTFILES}/claude/settings.json"
  else
    claude_settings_current=<(echo "")
  fi

  git diff --no-index --no-prefix --ignore-blank-lines --color ${claude_settings_current} ${claude_settings_new} || \
  ask "Do you accept changes in ${DOTFILES}/claude/settings.json?" && \
  cat ${claude_settings_new} > ${DOTFILES}/claude/settings.json
}


########################################
# Install dotfiles
########################################
arrow "Install dotfiles"

is_installed git && install_git
is_installed zsh && install_zsh
is_installed nvim && install_nvim
is_installed code && install_vs_code
is_installed iTerm.app && install_iterm
is_installed aws && install_aws
is_installed npm && install_npm
is_installed pip && install_pip
is_installed claude && install_claude
