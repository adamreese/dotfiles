#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -a "${DOTFILES}" ]] || die "${DOTFILES} directory does not exist"

echo "Installing default gems"
while read -r gemname; do
  gem install "$gemname"
done < "${DOTFILES}/ruby/default-gems"
