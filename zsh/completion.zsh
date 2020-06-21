# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# completion with menu
zstyle ':completion:*' menu select

# group completions
zstyle ':completion:*' group true
zstyle ':completion:*' group-name ''

# colors in menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# prompt for long lists
zstyle ':completion:*' select-prompt %SLine %l \(%p\)%s

# ignore zsh internal functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# SSH completion
hosts=(`awk '/^Host/ {for (i=2; i <= NF; i++) {gsub(/\*\.?/, "", $2); print $i}}' ~/.ssh/config ~/.ssh/config.d/*(.)`) 2> /dev/null
users=(`awk '/^[\t ]+User/ && !seen[$2]++ {print $2}' ~/.ssh/config ~/.ssh/config.d/*(.)`) 2> /dev/null

zstyle ':completion:*:(ssh|scp|rsync):*' hosts "$hosts[@]"
zstyle ':completion:*:(ssh|scp|rsync):*' users "$users[@]"
zstyle ':completion:*:(ssh|scp|rsync):*:hosts' list-colors '=*-=1;35' '=*=1;34'
zstyle ':completion:*:(ssh|scp|rsync):*:users' list-colors '=*=1;32'

autoload -Uz compinit
compinit
