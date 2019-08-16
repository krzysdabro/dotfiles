IS_OSX=`[[ "$(uname)" == "Darwin" ]] || return 1`

export ZSH=~/.zsh
export EDITOR=nvim
export PAGER=less

if [[ IS_OSX ]]; then
  export PATH=$PATH:/usr/local/sbin:/usr/local/opt/python/Frameworks/Python.framework/Versions/3.7/bin
  export FPATH=/usr/local/share/zsh-completions:$FPATH
  export LSCOLORS="ExGxFxdxCxdxDahbadacec"
  export LC_ALL=en_US
else
  export BROWSER=google-chrome-unstable
fi

for file in $ZSH/*.zsh; do
  . $file
done
