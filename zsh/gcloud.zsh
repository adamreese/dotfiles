# zsh gcloud
# -----------------------------------------------------------------------------

gcloud_path="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

# if [[ -s "${gcloud_path}/path.zsh.inc" ]]; then
#   source "${gcloud_path}/path.zsh.inc"
# fi

# if [[ -s "${gcloud_path}/completion.zsh.inc" ]]; then
#   source "${gcloud_path}/completion.zsh.inc"
# fi

# Completion
# -----------------------------------------------------------------------------
autoload -Uz zrecompile
typeset gcache=${HOME}/.cache/zsh/gcloud.zsh

if [[ ! -s $gcache || ${commands[gcloud]} -nt $gcache ]]; then
  egrep -v 'compinit' ${gcloud_path}/completion.zsh.inc >| $gcache
fi
zrecompile -p "${gcache}" && command rm -f "${gcache}.zwc.old"
[[ -s "${gcache}.zwc" ]] || zcompile $gcache
source $gcache

unset gcache
unset gcloud_path

# -----------------------------------------------------------------------------
# vim: ft=zsh :
