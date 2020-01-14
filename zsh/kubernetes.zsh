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

alias helm2="${GOPATH}/src/k8s.io/helm/bin/helm"

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

path[1,0]=${GOPATH}/src/github.com/Azure/brigade/bin

# Minikube
# -----------------------------------------------------------------------------

mkenv() {
  source <(minikube docker-env "$@")
}
