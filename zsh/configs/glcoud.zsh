# vim: ft=zsh :

gcloud_root="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

if [[ -f "${gcloud_root}/path.zsh.inc" ]]; then
  source "${gcloud_root}/path.zsh.inc"
fi

if [[ -f "${gcloud_root}/completion.zsh.inc" ]]; then
  source "${gcloud_root}/completion.zsh.inc"
fi
