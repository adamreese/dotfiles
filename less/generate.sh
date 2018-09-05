#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || { echo "${DOTFILES} directory does not exist"; exit 1; }

lesskey "${DOTFILES}/less/lesskey"
