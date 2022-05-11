#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || {
  echo "${DOTFILES} directory does not exist"
  exit 1
}

rustup completions zsh >"${DOTFILES}/zsh/completion/_rustup"
rustup completions zsh cargo >"${DOTFILES}/zsh/completion/_cargo"

# for checking and applying updates to installed executables
cargo install cargo-update cargo-edit cargo-play cargo-expand
