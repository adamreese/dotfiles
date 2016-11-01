# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[kubectl] )); then
  return 1
fi

export KUBE_ROOT=${GOPATH}/src/k8s.io/kubernetes

# Man path
# -----------------------------------------------------------------------------
if [[ ! "$MANPATH" == *${KUBE_ROOT}/docs/man* && -d "${KUBE_ROOT}/docs/man" ]]; then
  manpath+=("${KUBE_ROOT}/docs/man")
fi

# Completion
# -----------------------------------------------------------------------------
[[ $- == *i* ]] && source <(kubectl completion zsh)

alias k=kubectl
