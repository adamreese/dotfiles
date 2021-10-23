#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || {
  echo "${DOTFILES} directory does not exist"
  exit 1
}

echo "Installing default node packages"

npm install --global npm

while read -r pkg; do
  npm install --global --production "${pkg}"
done <"${DOTFILES}/node/default-packages"
