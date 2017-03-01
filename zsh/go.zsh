# zsh go
# -----------------------------------------------------------------------------
if (( ! $+commands[go] )); then
  return 1
fi

export GOPATH=${HOME}/p/go

path=(${GOPATH}/bin $path)

gocover() {
  go test ${1} -coverprofile=$TMPDIR/coverage.out
  go tool cover -html=$TMPDIR/coverage.out
}

# -----------------------------------------------------------------------------
# vim: ft=zsh :
