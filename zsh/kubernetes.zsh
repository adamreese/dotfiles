# zsh kubernetes
# -----------------------------------------------------------------------------
if (( ! $+commands[kubectl] )); then
  return 1
fi

# Kubernetes
# -----------------------------------------------------------------------------
alias k=kubectl

zcompcobra kubectl

# Helm
# -----------------------------------------------------------------------------
export HELM_HOST=:44134

path=(${GOPATH}/src/k8s.io/helm/bin ${path})

# HL global alias
# example: `helm get HL`
alias -g HL='$(helm last)'

# disable for now
# zcompcobra helm
if [[ -s "${ZSH_CACHE}/helm.zsh" ]]; then
  emulate bash -c 'source "${ZSH_CACHE}/helm.zsh"'
fi


# -----------------------------------------------------------------------------
# vim: ft=zsh :
