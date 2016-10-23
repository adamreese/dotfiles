# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[go] )); then
  return 1
fi

export GOPATH=${HOME}/p/go

path=(${GOPATH}/bin $path)


# cdg
#
# Change to directory from $GOPATH/src
cdg() {
  cd "${GOPATH}/src/github.com/${1}"
}

gml() {
  local -a args=("./...")

  if (( $# > 0 )); then
    args=($@)
  fi

  command gometalinter \
    --vendor \
    --disable=gotype \
    --enable=misspell \
    --sort=linter \
    --deadline=2m \
    --cyclo-over=20 \
    --dupl-threshold=80 \
    --concurrency=6 \
    $args
}
