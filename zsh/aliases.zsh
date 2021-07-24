alias reload=". ~/.zshrc"

alias vi="nvim"
alias vim="nvim"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

if [[ -n "${IS_DARWIN-}" ]]; then
  alias ls="ls -G"
  alias ll="ls -lah"
else
  alias ls="ls -N --color=auto --group-directories-first"
  alias ll="ls -lahv"
fi

# Other
if [[ -z "${IS_DARWIN-}" ]]; then
  alias ip="ip -br -c"
fi

alias rsync="rsync -P"
alias sudo="sudo "
