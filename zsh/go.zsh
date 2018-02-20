# zsh go
# -----------------------------------------------------------------------------
(( ${+commands[go]} )) || return

# Setup PATH for go
# -----------------------------------------------------------------------------
typeset -gx GOPATH=${HOME}/p/go
typeset -gx GOCACHE="${XDG_CACHE_HOME}/go-build"
path[1,0]=${GOPATH}/bin

# -----------------------------------------------------------------------------
# gocover
# Run test coverage on a package and open the results in a browser.
gocover() {
  local coverprofile=$(mktemp coverage.XXXXXX)
  go test -coverprofile "${coverprofile}" "$@" && go tool cover -html "${coverprofile}"
}

alias gml="gometalinter --config=${XDG_CONFIG_HOME}/gometalinter.json"

# -----------------------------------------------------------------------------
# Global alias pipe to panicparse.
#
# Usage:
#
#    go test PP
#
# Depends on github.com/maruel/panicparse
alias -g PP='|& pp'

# -----------------------------------------------------------------------------
# vim: ft=zsh :
