# zsh lua
# -----------------------------------------------------------------------------
(( ${+commands[luarocks]} )) || return

luarocks() {
  unfunction "$0"
  luadir=/usr/local/opt/lua@5.1
  [[ -d "$luadir" ]] || return
  eval $(luarocks --lua-dir=${luadir} path --bin)
  $0 "$@"
}

alias luarocks='luarocks --lua-dir="$luadir"'

# -----------------------------------------------------------------------------
# vim:ft=zsh
