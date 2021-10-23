#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || {
  echo "${DOTFILES} directory does not exist"
  exit 1
}

echo "Installing default gems"
while read -r gemname; do
  gem install "$gemname"
done <"${DOTFILES}/ruby/default-gems"
