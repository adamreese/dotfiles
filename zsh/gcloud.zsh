# zsh gcloud
# -----------------------------------------------------------------------------

: ${GCLOUD_SDK_ROOT:=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk}

[[ -e $GCLOUD_SDK_ROOT ]] || return

path[1,0]=${GCLOUD_SDK_ROOT}/bin
