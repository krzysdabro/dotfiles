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

# Start SSM session
ssm() {
  aws ssm start-session --target ${@}
}

# List EC2 instances
instances() {
  aws ec2 describe-instances --output=json ${@} | jq -r '.Reservations[].Instances[] | [(.Tags[] | select(.Key == "Name") | .Value), .InstanceId, .State.Name, .InstanceType, .PrivateIpAddress] | @tsv' | sort | column -t
}
