# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[travis] )); then
  return 1
fi

[[ -f "${HOME}/.travis/travis.sh" ]] && source "${HOME}/.travis/travis.sh"
