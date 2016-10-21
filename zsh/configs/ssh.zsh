# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[ssh-add] )); then
  return 1
fi

if ! ssh-add -l > /dev/null; then
  ssh-add -K 2> /dev/null
fi
