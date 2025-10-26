# Create a new directory and enter it
mkd() {
  mkdir -p "$@" && cd "$@"
}

# Return public IP
myip() {
  curl -w '\n' https://ipinfo.io/ip
}

# Search through history
hs() {
  history 0 | grep "$(echo $@)" | tail -20
}

# Boop makes a sound
boop() {
  afplay /System/Library/Sounds/Tink.aiff
}

backup() {
  dir=${1:-$PWD}
  repo=$HOME/.restic_repository

  [[ "$(realpath $dir)" =~ "^$HOME/work" && -f "$HOME/work/.restic_repository" ]] && repo=$HOME/work/.restic_repository

  restic --repository-file=$repo backup "$1" --exclude-file=$HOME/.restic_exclude
}

feedbin() {
  if [ -z "$1" ]; then
    echo "Usage: feedbin <URL>"
    return 1
  fi

  FEEDBIN_URL="$(op read op://Homelab/Feedbin/website)"
  FEEDBIN_PAGE_TOKEN="$(op read op://Homelab/Feedbin/token)"

  cloudflared access curl "${FEEDBIN_URL}/pages" -G --data "page_token=${FEEDBIN_PAGE_TOKEN}" --data-urlencode "url=${1}"
}
