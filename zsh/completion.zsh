# Completion waiting dots
expand-or-complete-with-dots() {
  echo -en "\e[0;90m...\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots

# Match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Completion with menu
zstyle ':completion:*' menu select

# Group completions
zstyle ':completion:*' group true
zstyle ':completion:*' group-name ''

# Colors in menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Prompt for long lists
zstyle ':completion:*' select-prompt %SLine %l \(%p\)%s

# Ignore zsh internal functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# Find new executables in path
zstyle ':completion:*' rehash true

# SSH completion
hosts=(`awk '/^Host/ {for (i=2; i <= NF; i++) {gsub(/\*\.?/, "", $2); print $i}}' ~/.ssh/config ~/.ssh/config.d/**/*(.)`) 2> /dev/null
users=(`awk '/^[\t ]+User/ && !seen[$2]++ {print $2}' ~/.ssh/config ~/.ssh/config.d/**/*(.)`) 2> /dev/null

zstyle ':completion:*:(ssh|scp|rsync):*' hosts "$hosts[@]"
zstyle ':completion:*:(ssh|scp|rsync):*' users "$users[@]"
zstyle ':completion:*:(ssh|scp|rsync):*:hosts' list-colors '=*-=1;35' '=*=1;34'
zstyle ':completion:*:(ssh|scp|rsync):*:users' list-colors '=*=1;32'

autoload -Uz compinit
autoload -U +X bashcompinit && bashcompinit
compinit

if which az &> /dev/null; then
  source $HOMEBREW_PREFIX/etc/bash_completion.d/az
fi
