# zsh kubernetes
# -----------------------------------------------------------------------------
(( ${+commands[kubectl]} )) || return

# Kubernetes
# -----------------------------------------------------------------------------

alias k=kubectl

zcompcobra kubectl

# Helm
# -----------------------------------------------------------------------------

# export HELM_HOST=:44134

path[1,0]=${GOPATH}/src/k8s.io/helm/bin

# HL global alias
# example: `helm get HL`
alias -g HL='$(helm last)'

# disable for now
# zcompcobra helm
if [[ -s "${ZSH_CACHE_DIR}/helm.zsh" ]]; then
  emulate bash -c 'source "${ZSH_CACHE_DIR}/helm.zsh"'
fi

# Minikube
# -----------------------------------------------------------------------------

mkenv() {
  source <(minikube docker-env "$@")
}

# -----------------------------------------------------------------------------
# vim: ft=zsh :
