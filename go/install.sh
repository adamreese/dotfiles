#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -a "${DOTFILES}" ]] || { echo "${DOTFILES} directory does not exist"; exit; }

is_repo_outdated() {
  (
  cd "${1:-.}"
  git rev-parse --is-inside-work-tree &>/dev/null &&
    git fetch &>/dev/null &&
    git rev-parse --abbrev-ref @'{u}' &>/dev/null &&
    (( $(git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null) > 0 ))
  )
}

echo "Installing default go packages"
while read -r pkg; do
  dir="${GOPATH}/src/${pkg%...}"
  if [[ ! -d "${dir}" ]] || is_repo_outdated "${dir}"; then
    echo "${pkg}"
    go get -u "${pkg}"
  fi
done < "${DOTFILES}/go/default-packages"
