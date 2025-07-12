brew "azure-cli"
brew "helmsman"
brew "kubelogin"
brew "ruby"
brew "tfenv"
brew "tflint"
brew "tfsec"

cask "gcloud-cli", postinstall: "${HOMEBREW_PREFIX}/bin/gcloud components update"
cask "headlamp"

vscode "hashicorp.terraform"
vscode "redhat.java"

# Patch google-cloud-sdk completion for zsh
def patch_gcloud
  path = "#{HOMEBREW_PREFIX}/share/zsh/site-functions/_google_cloud_sdk"
  return unless File.exist?(path)

  line = "#compdef gcloud gsutil bq\n"
  content = File.read(path)
  File.write(path, line + content) unless content.start_with?(line)
end

patch_gcloud
