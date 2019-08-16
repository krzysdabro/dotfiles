# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# completion with menu
zstyle ':completion:*' menu select

# colors in menu
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# prompt for long lists
zstyle ':completion:*' select-prompt %SLine %l \(%p\)%s

# hosts completion
_ssh_config=()
if [[ -f ~/.ssh/config ]]; then
  _ssh_config+=(`cat ~/.ssh/config | sed -ne '/*[^\*]*/d' -e 's/^Host[=\t ]//p'`)
fi
hosts=(
  "$_ssh_config[@]"
  `hostname`
  localhost
)
zstyle ':completion:*:hosts' hosts $hosts

# users completion
users=($(awk -F':' '{if (($3 >= 1000 || $3 == 0) && $1 != "nobody") print $1}' /etc/passwd))
zstyle ':completion:*:users' users $users
zstyle ':completion:*:(ssh|scp|rsync):*:users' users

autoload -Uz compinit
compinit
