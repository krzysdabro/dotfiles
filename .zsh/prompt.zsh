__git_ps1() {
  _branch=$(git symbolic-ref HEAD 2> /dev/null) || exit

  # worktree status
  _color="green"
  $(git diff --no-ext-diff --quiet --cached) || _color="yellow"
  $(git diff --no-ext-diff --quiet) || _color="red"

  # branch status
  local=$(git rev-parse @ 2> /dev/null)
  remote=$(git rev-parse @{u} 2> /dev/null)
  base=$(git merge-base @ @{u} 2> /dev/null)

  if [[ "$(git remote show)" == "" ]]; then _status="×"
  elif [[ $local == $remote ]]; then _status="≡"
  elif [[ $local == $base ]]; then _status="↓"
  elif [[ $remote == $base ]]; then _status="↑"
  else _status="↕" fi


  echo " [%F{$_color}${_branch##refs/heads/}%f $_status]"
}

if [[ "$SSH_CONNECTION" != "" ]]; then
  __color_ps1="yellow"
fi

if ! [[ "$OSTYPE" =~ ^darwin ]]; then
  RPS1="\$(__git_ps1)"
fi

PS1="[%F{${__color_ps1:-green}}%n@%m%f %F{blue}%~%f] "
