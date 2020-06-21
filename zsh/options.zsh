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
bindkey "\e[H"     beginning-of-line
bindkey "\e[F"     end-of-line
bindkey "\e\e[D"   backward-word
bindkey "\e[1;3D"  backward-word
bindkey "\e\e[C"   forward-word
bindkey "\e[1;3C"  forward-word
bindkey "\e[3~"    delete-char
bindkey "\e[Z"     reverse-menu-complete