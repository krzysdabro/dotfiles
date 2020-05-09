export ZSH=$HOME/.zsh
export EDITOR=nvim
export PAGER=less
export GPG_TTY=$(tty)
export LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=33:cd=1;33;40:su=37;41:sg=30;43:tw=30;42:ow=34;42"

if which go &> /dev/null; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

if [[ "$OSTYPE" =~ ^darwin ]]; then
  export FPATH=/usr/local/share/zsh-completions:$FPATH
  export LSCOLORS="ExGxFxdxCxdxDahbadacec"
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
fi

for file in $ZSH/*.zsh; do
  . $file
done
