myip() {
  curl https://ipinfo.io/ip
}

weather() {
  curl https://wttr.in/${1:-Poznan}\?2mnq
}
