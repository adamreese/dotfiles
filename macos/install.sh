#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || {
  echo "${DOTFILES} directory does not exist"
  exit 1
}

# install brew
# -----------------------------------------------------------------------------
install_homebrew() {
  if ! command -v brew >/dev/null; then
    announce_step "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

mkdir -p "${HOME}/Library/KeyBindings"

ln -sf "${DOTFILES}/macos/DefaultKeybinding.dict" "${HOME}/Library/KeyBindings/DefaultKeybinding.dict"
