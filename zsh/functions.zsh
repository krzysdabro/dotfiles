# Create a new directory and enter it
mkd() {
  mkdir -p "$@" && cd "$@"
}

# Return public IP
myip() {
  curl https://ipinfo.io/ip
}

# Search through history
hs() {
  history 0 | grep "$(echo $@)" | tail -20
}
