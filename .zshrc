export ZSH=~/.zsh
export EDITOR=nvim
export PAGER=less
export GPG_TTY=$(tty)

if [[ "$OSTYPE" =~ ^darwin ]]; then
  export PATH=$PATH:/usr/local/sbin:/usr/local/opt/python/Frameworks/Python.framework/Versions/3.7/bin
  export FPATH=/usr/local/share/zsh-completions:$FPATH
  export LSCOLORS="ExGxFxdxCxdxDahbadacec"
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
else
  export BROWSER=google-chrome-unstable
fi

for file in $ZSH/*.zsh; do
  . $file
done
