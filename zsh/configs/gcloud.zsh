# vim: ft=zsh :

gcloud_path="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

if [[ -f "${gcloud_path}/path.zsh.inc" ]]; then
  source "${gcloud_path}/path.zsh.inc"
fi

if [[ -f "${gcloud_path}/completion.zsh.inc" ]]; then
  source "${gcloud_path}/completion.zsh.inc"
fi

unset gcloud_path
