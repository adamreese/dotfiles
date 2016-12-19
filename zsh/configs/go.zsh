# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[go] )); then
  return 1
fi

export GOPATH=${HOME}/p/go

path=(${GOPATH}/bin $path)
