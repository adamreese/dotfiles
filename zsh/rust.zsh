# zsh rust
# -----------------------------------------------------------------------------

# Setup PATH for rust
# -----------------------------------------------------------------------------
path+=${HOME}/.cargo/bin

(( ${+commands[rustup]} )) || return

rustup() {
  unfunction "$0"
  source <(command rustup completions zsh)
  $0 "$@"
}
