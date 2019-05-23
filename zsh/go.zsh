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

# https://github.com/y0ssar1an/q
qq() {
  emulate -L zsh
  clear

  local logpath="$TMPDIR/q"
  if [[ ! -f "$logpath" ]]; then
    echo 'Q LOG' > "$logpath"
  fi

  tail -100f -- "$logpath"
}

rmqq() {
  rm -f "$TMPDIR/q"
  qq
}

# -----------------------------------------------------------------------------
# vim: ft=zsh :
