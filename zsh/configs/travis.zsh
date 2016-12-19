# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[travis] )); then
  return 1
fi

if [[ -f "${HOME}/.travis/travis.sh" ]]; then
  source "${HOME}/.travis/travis.sh"
fi
