#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -a "${DOTFILES}" ]] || { echo "${DOTFILES} directory does not exist"; exit 1; }

echo "Updating global pip"
pip3 install --upgrade pip

echo "Updating global pip requirements"
pip3 install --upgrade --requirement "${DOTFILES}/python/requirements.txt"
