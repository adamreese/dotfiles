#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -a "${DOTFILES}" ]] || die "${DOTFILES} directory does not exist"

echo "Installing default node packages"
while read -r pkg; do
  npm install --global --production "${pkg}"
done < "${DOTFILES}/node/default-packages"
