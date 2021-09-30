#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || { echo "${DOTFILES} directory does not exist"; exit 1; }

echo "Updating global pip"
python3 -m pip install --upgrade pip

echo "Updating global pip requirements"
python3 -m pip install --upgrade --requirement "${DOTFILES}/python/requirements.txt"
