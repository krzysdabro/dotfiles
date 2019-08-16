docker-tools() {
  docker run -itv $HOME:/root krzysdabro/tools:latest
}

myip() {
  curl https://ipinfo.io/ip
}

transfer() {
  file="${1:t}"
  curl --upload-file "$1" --progress-bar -H "Max-Downloads: 1" "https://transfer.sh/$file"
}

weather() {
  curl https://wttr.in/${1:-Poznan}\?2mnq
}
