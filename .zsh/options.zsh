setopt auto_cd
setopt complete_in_word
setopt correct
setopt globdots
setopt prompt_subst

# History
setopt append_history
setopt share_history
setopt inc_append_history
setopt hist_ignore_dups

HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=2000

# Key bindings
bindkey -e
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kcbt]}" reverse-menu-complete

# nvim terminal mode
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
