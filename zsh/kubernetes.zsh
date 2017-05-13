# zsh kubernetes
# -----------------------------------------------------------------------------
if (( ! $+commands[kubectl] )); then
  return 1
fi

# Completion
# -----------------------------------------------------------------------------
autoload -Uz zrecompile

# zcmp
#
# compile and source cobra style zsh completions
zcmp() {
  typeset cachefile=${HOME}/.cache/zsh/${1}.zsh

  if [[ ! -s $cachefile || ${commands[${1}]} -nt $cachefile ]]; then
    "${1}" completion zsh | egrep -v 'compinit' >| $cachefile
  fi

  zrecompile -p "${cachefile}" && command rm -f "${cachefile}.zwc.old"
  [[ -s "${cachefile}.zwc" ]] || zcompile $cachefile
  source $cachefile
}


# Kubernetes
# -----------------------------------------------------------------------------
alias k=kubectl

zcmp kubectl

# Helm
# -----------------------------------------------------------------------------
export HELM_HOST=:44134

path=(${GOPATH}/src/k8s.io/helm/bin ${path})

# HL global alias
# example: `helm get HL`
alias -g HL='$(helm last)'

zcmp helm

# -----------------------------------------------------------------------------
# vim: ft=zsh :
