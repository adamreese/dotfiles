# zsh rust
# -----------------------------------------------------------------------------

# Setup PATH for rust
# -----------------------------------------------------------------------------
path+=${HOME}/.cargo/bin

(( ${+commands[rustup]} )) || return

() {
  local cache=${ZDOTDIR:?}/completion/_rustup

  if [[ ! -s $cache || ${commands[rustup]} -nt $cache ]]; then
    rustup completions zsh >| $cache
  fi
} || echo 'Failed to write rustup completion' >&2

# -----------------------------------------------------------------------------
# vim: ft=zsh :
