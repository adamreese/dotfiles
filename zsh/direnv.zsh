# zsh direnv
# -----------------------------------------------------------------------------
(( ${+commands[direnv]} )) || return

source <(direnv hook zsh)

# -----------------------------------------------------------------------------
# vim:ft=zsh
