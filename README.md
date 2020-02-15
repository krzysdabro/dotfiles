# Dotfiles

```
git clone --bare git@github.com:krzysdabro/dotfiles.git $HOME/.dotfiles
alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
config checkout
config submodule init
config config --local status.showUntrackedFiles no

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
