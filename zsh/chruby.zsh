# zsh chruby
# -----------------------------------------------------------------------------

# use system ruby for now
return 1

(( ${+commands[chruby-exec]} )) || return

source "${commands[chruby-exec]:h:h}/share/chruby/chruby.sh"
source "${commands[chruby-exec]:h:h}/share/chruby/auto.sh"

chruby ruby-2.4

# -----------------------------------------------------------------------------
# vim:ft=zsh
