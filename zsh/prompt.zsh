__git_ps1() {
  _branch=$(git symbolic-ref HEAD 2> /dev/null) || \
  _branch=$(git rev-parse --short HEAD 2> /dev/null) || exit

  # worktree status
  _color="green"
  $(git diff --no-ext-diff --quiet --cached) || _color="yellow"
  $(git diff --no-ext-diff --quiet) || _color="red"

  # remote status
  local=$(git rev-parse @ 2> /dev/null)
  remote=$(git rev-parse @{u} 2> /dev/null)
  base=$(git merge-base @ @{u} 2> /dev/null)

  if [[ $remote == "" ]]; then _status="×"                # Missing
  elif [[ $local == $remote ]]; then _status="≡"          # Up to date
  elif [[ $local == $base ]]; then _status="↓"            # Behind
  elif [[ $remote == $base ]]; then _status="↑"           # Ahead
  else _status="↕" fi                                     # Diverged


  echo " [%F{$_color}${_branch##refs/heads/}%f $_status]"
}

__aws_ps1() {
  [[ -z "${AWS_PROFILE}" ]] && exit

  echo " [%F{yellow}${AWS_PROFILE}%f]"
}

__terraform_ps1() {
  [[ ! -d .terraform || ! -f .terraform/environment ]] && exit
  workspace=$(cat .terraform/environment)

  echo " [%F{magenta}${workspace}%f]"
}

if [[ "$SSH_CONNECTION" != "" ]]; then
  __color_ps1="yellow"
elif [[ -f /.dockerenv ]]; then
  __color_ps1="cyan"
fi

RPS1="\$(__aws_ps1)\$(__terraform_ps1)\$(__git_ps1)"
PS1="[%F{${__color_ps1:-green}}%n@%m%f %F{blue}%~%f] "
