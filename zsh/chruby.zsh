# zsh chruby
# -----------------------------------------------------------------------------
path[1,0]=/usr/local/opt/ruby/bin
return

(( ${+commands[chruby-exec]} )) || return

source "${commands[chruby-exec]:h:h}/share/chruby/chruby.sh"
source "${commands[chruby-exec]:h:h}/share/chruby/auto.sh"

chruby ruby-2.5
