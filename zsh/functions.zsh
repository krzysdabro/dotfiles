# Create a new directory and enter it
mkd() {
  mkdir -p "$@" && cd "$@"
}

# Return public IP
myip() {
  curl https://ipinfo.io/ip
}

# Run container with tools
docker-tools() {
  docker run -itv "$HOME:/root" --network host -w "${PWD/$HOME//root}" --rm krzysdabro/tools:latest
}

# Search through history
function hs() {
  history 0 | grep "$(echo $@)" | tail -20
}
