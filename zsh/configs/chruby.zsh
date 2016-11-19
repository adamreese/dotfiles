# vim: ft=zsh :

# Return if reqs are not found
if (( ! $+commands[chruby-exec] )); then
  return 1
fi

chruby_root="/usr/local/share/chruby"

if [[ -f "${chruby_root}/chruby.sh" ]]; then
  source "${chruby_root}/chruby.sh"
fi

if [[ -f "${chruby_root}/auto.sh" ]]; then
  source "${chruby_root}/auto.sh"
fi

if (( $+functions[chruby] )); then
  chruby ruby-2.3
fi
