# zsh kubernetes
# -----------------------------------------------------------------------------
(( ${+commands[kubectl]} )) || return

# Kubernetes
# -----------------------------------------------------------------------------

alias k=kubectl

# Helm
# -----------------------------------------------------------------------------

# export HELM_HOST=:44134

path[1,0]=${GOPATH}/src/helm.sh/helm/bin

# HL global alias
# example: `helm get HL`
alias -g HL='$(helm last)'

helm() {
  unfunction "$0"
  source <(command helm completion zsh)
  $0 "$@"
}

# Brigade
# -----------------------------------------------------------------------------

export BRIGADE_NAMESPACE=brigade-dev
export BRIGADE_PROJECT_NAMESPACE=${BRIGADE_NAMESPACE}

path[1,0]=${GOPATH}/src/github.com/Azure/brigade/bin

# Minikube
# -----------------------------------------------------------------------------

mkenv() {
  source <(minikube docker-env "$@")
}

# -----------------------------------------------------------------------------
# vim: ft=zsh :
