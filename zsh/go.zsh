# zsh go
# -----------------------------------------------------------------------------
(( ${+commands[go]} )) || return

typeset -gx GOPATH=${HOME}/p
typeset -gx GOCACHE="${XDG_CACHE_HOME}/go-build"
path[1,0]=${GOPATH}/bin

alias glci="golangci-lint run --config=${DOTFILES}/go/golangci.yml"

# -----------------------------------------------------------------------------
# Global alias pipe to panicparse.
#
# Usage:
#
#    go test PP
#
# Depends on github.com/maruel/panicparse

alias -g PP='|& pp'

# ------------------------------------------------------------------------------
# hash directories

hash -d -- goroot=$(go env GOROOT)
hash -d -- gosrc=${GOPATH}/src
