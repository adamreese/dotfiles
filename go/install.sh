#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || { echo "${DOTFILES} directory does not exist"; exit 1; }

is_repo_outdated() {
  (
    cd "${1:-.}"
    git rev-parse --is-inside-work-tree &>/dev/null &&
      git fetch &>/dev/null &&
      git rev-parse --abbrev-ref @'{u}' &>/dev/null &&
      (($(git rev-list --right-only --count HEAD...@'{u}' 2>/dev/null) > 0))
  )
}

is_repo_dirty() {
  test -n "$(git status --porcelain --ignore-submodules -unormal)"
}

update() {
  local pkg="${1}"

  if [[ "$pkg" =~ @ ]]; then
    echo ":: Upgrading module ${pkg}"
    GO111MODULE=on go get -v "$pkg"
  else
    local dir="${GOPATH}/src/${pkg%...}"
    if ((rebuild)) || is_repo_outdated "${dir}"; then

      echo ":: Upgrading ${pkg}"
      cd "${dir}"

      if is_repo_dirty; then
        git -C "${dir}" reset --hard
        echo "[skipping] ${pkg} has uncommitted changes"
      else
        git pull >/dev/null
        go install ./...
      fi
    fi
  fi
}

rebuild=0
while (($#)); do
  case "$1" in
  -r | --rebuild)
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
  update "${pkg}"
done <"${DOTFILES}/go/default-packages"
