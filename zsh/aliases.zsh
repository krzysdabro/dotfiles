alias reload=". ~/.zshrc"
alias incognito=" unset HISTFILE"
alias sudo="sudo "

alias vi="nvim"
alias vim="nvim"

alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

alias rsync="rsync -P"

alias k="kubectl"
alias tf="terraform"

alias erase="shred --remove"

if [[ -n "${IS_DARWIN-}" ]]; then
  alias ls="ls -G"
  alias ll="ls -lah"

  alias copy="pbcopy"
  alias pasta="pbpaste"

  alias afk="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'"
else
  alias ls="ls -N --color=auto --group-directories-first"
  alias ll="ls -lahv"

  alias ip="ip -br -c"
fi

if [[ -z "${IS_DARWIN-}" ]]; then
  alias ip="ip -br -c"
fi

if [[ "$(hostname)" =~ "EGN-" ]]; then
  alias gkms-encrypt=" EYAML_CONFIG=.eyaml/config.yaml eyaml encrypt -s"
  alias gkms-decrypt=" EYAML_CONFIG=.eyaml/config.yaml eyaml decrypt -s"
  alias fed-gkms-encrypt=" EYAML_CONFIG=.eyaml/config.yaml fedctl eyaml encrypt -s"
  alias fed-gkms-decrypt=" EYAML_CONFIG=.eyaml/config.yaml fedctl eyaml decrypt -s"
fi
