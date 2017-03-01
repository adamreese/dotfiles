# zsh kubernetes
# -----------------------------------------------------------------------------
if (( ! $+commands[kubectl] )); then
  return 1
fi

# Aliases
# -----------------------------------------------------------------------------
alias k=kubectl

# Completion
# -----------------------------------------------------------------------------
autoload -Uz zrecompile
typeset kubecache=${HOME}/.cache/zsh/kubectl.zsh

if [[ ! -s $kubecache || ${commands[kubectl]} -nt $kubecache ]]; then
  kubectl completion zsh | egrep -v 'compinit' >| $kubecache
fi
zrecompile -p "${kubecache}" && command rm -f "${kubecache}.zwc.old"
[[ -s "${kubecache}.zwc" ]] || zcompile $kubecache
source $kubecache

unset kubecache

# Helm
# -----------------------------------------------------------------------------
export HELM_HOST=:44134

path=(${GOPATH}/src/k8s.io/helm/bin ${path})

# -----------------------------------------------------------------------------
# vim: ft=zsh :
