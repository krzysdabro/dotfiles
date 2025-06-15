export ZSH=$HOME/.zsh
export EDITOR=nvim
export PAGER=less
export LS_COLORS="di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=33:cd=1;33;40:su=37;41:sg=30;43:tw=30;42:ow=34;42"

# Check if script runs on MacOS
if [[ "$OSTYPE" =~ ^darwin ]]; then
  IS_DARWIN=1
fi

# Check if script runs on ARM architecture
if [[ "$(/usr/bin/uname -m)" == "arm64" ]]; then
  IS_ARM=1
fi

# Add Homebrew to PATH on ARM architecture
if [[ -n "${IS_ARM-}" && -d /opt/homebrew ]]; then
  export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
fi

# Check if Homebrew is installed
if which brew &> /dev/null; then
  export HOMEBREW_PREFIX=$(brew --prefix)
  export MANPATH=$HOMEBREW_PREFIX/share/man:$MANPATH
  export FPATH=$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH
fi

# Check if Go is installed
if which go &> /dev/null; then
  export GOPATH=$HOME/go
  export PATH=$PATH:$GOPATH/bin
fi

# Check if Gem is installed
if which gem &> /dev/null; then
  export PATH=$PATH:$(gem environment home)/bin
fi

# Check if Google Cloud SDK is installed
if which gcloud &> /dev/null; then
  export PATH=$PATH:$HOMEBREW_PREFIX/share/google-cloud-sdk/bin
fi

if [[ -n "${IS_DARWIN-}" ]]; then
  export LSCOLORS="ExGxFxdxCxdxDahbadacec"
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
fi

for file in $ZSH/*.zsh; do
  . $file
done
