#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || {
  echo "${DOTFILES} directory does not exist"
  exit 1
}

echo "Installing default go packages"

while read -r pkg; do
  echo ":: ${pkg}"
  GO111MODULE=on go install -v "$pkg"
done <"${DOTFILES}/go/default-packages"

echo :: github.com/mickael-menu/zk
cd "${GOPATH}/src/github.com/mickael-menu/zk"
git pull
make install
