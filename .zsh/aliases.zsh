alias reload=". ~/.zshrc"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

if [[ IS_OSX ]]; then
  alias ls="ls -G"
  alias ll="ls -lah"
else
  alias ls="ls -N --color=auto --group-directories-first"
  alias ll="ls -lahv"
fi

# Other
if [[ IS_OSX ]]; then
  alias ip="ip -br -c"
fi
alias rsync="rsync -P"
alias sudo="sudo "

