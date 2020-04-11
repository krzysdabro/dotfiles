#!/bin/bash

C_RED="\e[0;31m"
C_YELLOW="\e[0;33m"
C_BLUE="\e[0;34m"
C_RESET="\e[0m"

DOTFILES="$HOME/.dotfiles"

dotfiles() {
  git --git-dir="$DOTFILES" --work-tree="$HOME" $@
}

info() {
  printf "${C_BLUE}::${C_RESET}  $@\n"
}

error() {
  printf "${C_RED}::${C_RESET}  Error: $@\n"
  exit 1
}

arrow() {
  printf "${C_YELLOW}==>${C_RESET}  $@\n"
}

git_2_25_0() {
  git_version=`git version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+'`
  min_version="2.25.0"

  [[ "$min_version" == "$(echo -e "$git_version\n$min_version" | sort -V | head -1)" ]]
}


if [[ ! -d $DOTFILES ]]; then
  info "Setting up dotfiles in ${C_YELLOW}$DOTFILES${C_RESET}"
  git clone --bare git@github.com:krzysdabro/dotfiles.git $DOTFILES || error "Cannot clone repository"
  dotfiles config --local status.showUntrackedFiles no
fi


if ! git_2_25_0; then
  error "Version 2.25.0 or later is required to use sparse-checkout"
fi

if ! dotfiles diff --no-ext-diff --quiet &> /dev/null; then
  error "Your index contains uncommitted changes"
fi

if ! dotfiles config core.sparseCheckout &> /dev/null; then
  info "Initializing sparse-checkout"
  dotfiles sparse-checkout init || error "Cannot initialize sparse-checkout"
fi

info "Pulling changes"
dotfiles pull

info "Installing files"
FILES=(bootstrap.sh .config/git/)

if [[ "$OSTYPE" =~ ^darwin ]]; then
  arrow "MacOS"
  FILES+=(Brewfile .macos .config/iTerm2/)
fi

if which zsh &> /dev/null; then
  arrow "Zsh"
  FILES+=(.zlogin .zshrc .zsh/)
fi

if which nvim &> /dev/null; then
  arrow "Neovim"
  FILES+=(.config/nvim/)
  curl -sLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

dotfiles sparse-checkout set ${FILES[@]}
