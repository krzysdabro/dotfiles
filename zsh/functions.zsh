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

# Initialize Terraform with Gitlab Terraform State
tf-gitlab-init() {
  gitlab_url_file="$HOME/.gitlab_url"
  gitlab_username_file="$HOME/.gitlab_username"
  gitlab_token_file="$HOME/.gitlab_token"

  gitlab_url="https://gitlab.com"
  gitlab_username=""
  gitlab_token=""

  [[ -f "$gitlab_url_file" ]] && gitlab_url=$(cat "$gitlab_url_file")
  [[ -f "$gitlab_username_file" ]] && gitlab_username=$(cat "$gitlab_username_file")
  [[ -f "$gitlab_token_file" ]] && gitlab_token=$(cat "$gitlab_token_file")

  gitlab_url=$(gum input --prompt "Gitlab URL: " --placeholder "https://gitlab.com" --value "$gitlab_url")
  [[ "$gitlab_url" == "" ]] && return

  gitlab_username=$(gum input --prompt "Gitlab username: " --placeholder "user" --value "$gitlab_username")
  [[ "$gitlab_username" == "" ]] && return

  gitlab_token=$(gum input --prompt "Gitlab token: " --placeholder "glpat-xxxxxxxxxxxxxxxxxxx" --password --value "$gitlab_token")
  [[ "$gitlab_token" == "" ]] && return

  project_id=$(gum input --prompt "Gitlab project ID: " --placeholder "123")
  [[ "$project_id" == "" ]] && return

  state_name=$(gum input --prompt "Terraform state name: " --placeholder "production")
  [[ "$state_name" == "" ]] && return

  confirm_save=$(gum confirm "Do you want to save credentials?" && echo "yes")
  if [[ "$confirm_save" -eq "yes" ]]; then
    echo $gitlab_url > $gitlab_url_file
    echo $gitlab_username > $gitlab_username_file
    echo $gitlab_token > $gitlab_token_file
    chmod 600 $gitlab_token_file $gitlab_username_file $gitlab_token_file
  fi

  gum spin --spinner minidot --title "Initializing Terraform" --show-output -- terraform init \
    -backend-config="address=$gitlab_url/api/v4/projects/$project_id/terraform/state/$state_name" \
    -backend-config="lock_address=$gitlab_url/api/v4/projects/$project_id/terraform/state/$state_name/lock" \
    -backend-config="unlock_address=$gitlab_url/api/v4/projects/$project_id/terraform/state/$state_name/lock" \
    -backend-config="username=$gitlab_username" \
    -backend-config="password=$gitlab_token" \
    -backend-config="lock_method=POST" \
    -backend-config="unlock_method=DELETE" \
    -backend-config="retry_wait_min=5" \
    -input=false \
    -reconfigure
}

backup() {
  dir=${1:-$PWD}
  repo=$HOME/.restic_repository

  [[ "$(realpath $dir)" =~ "^$HOME/work" && -f "$HOME/work/.restic_repository" ]] && repo=$HOME/work/.restic_repository

  restic --repository-file=$repo backup "$1" --exclude-file=$HOME/.restic_exclude
}
