# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[chruby-exec] )); then
  return 1
fi

source "${commands[chruby-exec]:h:h}/share/chruby/chruby.sh"
source "${commands[chruby-exec]:h:h}/share/chruby/auto.sh"

chruby ruby-2.3
