#!/usr/bin/env bash
set -euxo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || die "${DOTFILES} directory does not exist"

brewfile="${DOTFILES}/macos/Brewfile"

brew bundle dump --describe --force --file="${brewfile}"
