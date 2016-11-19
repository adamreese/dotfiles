# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[kubectl] )); then
  return 1
fi

kube_root=${GOPATH}/src/k8s.io/kubernetes

# Man path
# -----------------------------------------------------------------------------
if [[ ! "$MANPATH" == *${kube_root}/docs/man* && -d "${kube_root}/docs/man" ]]; then
  manpath+=("${kube_root}/docs/man")
fi

# Completion
# -----------------------------------------------------------------------------
[[ $- == *i* ]] && source <(kubectl completion zsh)

alias k=kubectl
