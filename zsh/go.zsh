# zsh go
# -----------------------------------------------------------------------------
if (( ! $+commands[go] )); then
  return 1
fi

# Setup PATH for go
# -----------------------------------------------------------------------------
export GOPATH=${HOME}/p/go
path=(${GOPATH}/bin $path)

# -----------------------------------------------------------------------------
# gocover
# Run test coverage on a package and open the results in a browser.
gocover() {
  go test ${1} -coverprofile=$TMPDIR/coverage.out
  go tool cover -html=$TMPDIR/coverage.out
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
