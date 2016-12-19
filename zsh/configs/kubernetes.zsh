# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[kubectl] )); then
  return 1
fi

# Aliases
# -----------------------------------------------------------------------------
alias k=kubectl

# Man path
# -----------------------------------------------------------------------------
manpath+=($GOPATH/src/k8s.io/kubernetes/docs/man(N-/))

# Completion
# -----------------------------------------------------------------------------
() {
  local cache=${ZSH_CACHE_DIR}/kubectl.zsh

  if [[ ! -s $cache || ${commands[kubectl]} -nt $cache ]]; then
    kubectl completion zsh | egrep -v 'compinit' >| $cache
  fi
  source $cache
}
