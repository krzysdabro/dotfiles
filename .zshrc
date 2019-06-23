export ZSH=~/.zsh
export EDITOR=nvim
export PAGER=less
#export BROWSER=google-chrome-unstable

is_osx() {
  [[ "$(uname)" == "Darwin" ]] || return 1
}

for file in $ZSH/*.zsh; do
  if [[ "${file:t}}" == "osx" ]] continue
  . $file
done

is_osx && . $ZSH/osx.zsh
