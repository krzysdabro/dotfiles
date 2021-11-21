setopt auto_cd
setopt complete_in_word
setopt correct
setopt globdots
setopt prompt_subst

# History
setopt append_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space

HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=2000

# Key bindings
bindkey -e
bindkey "\e[H"     beginning-of-line        # [Home] - move cursor to beginning of line
bindkey "\e[F"     end-of-line              # [End] - move cursor to end of line
bindkey "\e\e[D"   backward-word            # [Alt-LeftArrow] - move cursor one word backward
bindkey "\e[1;3D"  backward-word
bindkey "\e\e[C"   forward-word             # [Alt-RightArrow] - move cursor one word forward
bindkey "\e[1;3C"  forward-word
bindkey "\e[3~"    delete-char              # [Delete] - delete character
bindkey "\e[Z"     reverse-menu-complete    # [Shift-Tab] - move through the completion menu backwards
