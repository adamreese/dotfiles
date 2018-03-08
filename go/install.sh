#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || { echo "${DOTFILES} directory does not exist"; exit 1; }

is_repo_outdated() {
  (
    cd "${1:-.}"
    git rev-parse --is-inside-work-tree &&
      git fetch -q &&
      git rev-parse --abbrev-ref @'{u}' &&
      (($(git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null) > 0))
  )
}

update() {
  local pkg="${1}"
  dir="${GOPATH}/src/${pkg%...}"
  if [[ ! -d "${dir}" ]] || is_repo_outdated "${dir}"; then
    echo "${pkg}"
    go get -u "${pkg}"
  fi
}

rebuild=0
while (($# > 0)); do
  case "$1" in
    -r,--rebuild)
      rebuild=1
      ;;
    *)
      break # end of options, just arguments left
      ;;
  esac
  shift
done

echo "Installing default go packages"
while read -r pkg; do
  if ((rebuild)); then
    go get -u -a "${pkg}"
  else
    update "${pkg}"
  fi
done <"${DOTFILES}/go/default-packages"
