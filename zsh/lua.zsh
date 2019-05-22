# zsh lua
# -----------------------------------------------------------------------------
(( ${+commands[luarocks]} )) || return

luadir=/usr/local/opt/lua@5.1

[[ -d "$luadir" ]] || return

eval $(luarocks --lua-dir=${luadir} path --bin)
alias luarocks='luarocks --lua-dir="$luadir"'

# -----------------------------------------------------------------------------
# vim:ft=zsh
