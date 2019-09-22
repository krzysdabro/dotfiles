export ZSH=~/.zsh
export EDITOR=nvim
export PAGER=less

if [[ "$OSTYPE" =~ ^darwin ]]; then
  export PATH=$PATH:/usr/local/sbin:/usr/local/opt/python/Frameworks/Python.framework/Versions/3.7/bin
  export FPATH=/usr/local/share/zsh-completions:$FPATH
  export LSCOLORS="ExGxFxdxCxdxDahbadacec"
else
  export BROWSER=google-chrome-unstable
fi

for file in $ZSH/*.zsh; do
  . $file
done
