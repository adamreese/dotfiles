path=(
  .git/safe/../../bin # mkdir .git/safe in the root of repositories you trust
  ${HOME}/.dotfiles/bin
  /usr/local/{bin,sbin}
  $path
)

export -U PATH

