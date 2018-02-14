#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -a "${DOTFILES}" ]] || die "${DOTFILES} directory does not exist"

echo "Updating global pip"
pip3 install --upgrade pip

echo "Updating global pip requirements"
pip3 install --upgrade --requirement "${DOTFILES}/python/requirements.txt"
