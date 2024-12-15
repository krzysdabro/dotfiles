brew "ruby"

cask "google-cloud-sdk"

# Patch google-cloud-sdk completion for zsh
def patch_google_cloud_sdk
  path = "#{HOMEBREW_PREFIX}/share/zsh/site-functions/_google_cloud_sdk"
  return unless File.exist?(path)

  line = "#compdef gcloud gsutil bq\n"
  content = File.read(path)
  File.write(path, line + content) unless content.start_with?(line)
end

patch_google_cloud_sdk
