#!/usr/bin/env bash

# Bash 'Strict Mode'
# http://redsymbol.net/articles/unofficial-bash-strict-mode
set -euo pipefail
IFS=$'\n\t'

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || die "${DOTFILES} directory does not exist"

# die
# -----------------------------------------------------------------------------
die() {
  # ${BASH_SOURCE[1]} is the file name of the caller.
  local error="${1:-Unknown Error.}"
  local code="${2:-1}"
  printf >&2 '\e[0;31m  [✖] %s:%s: %s (exit %s)\e[0m\n' \
    "${BASH_SOURCE[1]}" \
    "${BASH_LINENO[0]}" \
    "${error}" \
    "${code}"
  exit "${code}"
}

# onerror
# -----------------------------------------------------------------------------
onerror() {
  local lasterr="$?"
  local bash_command=${BASH_COMMAND}
  die "${BASH_SOURCE[1]}:${BASH_LINENO[0]} ('$bash_command' exited with status $lasterr)"
}
trap onerror ERR

# announce_step
# -----------------------------------------------------------------------------
announce_step() {
  printf '\033[0;32m \u279E   \033[0;0m%s\n' "$*"
}

print_error() {
  printf '\e[0;31m  [✖] %s %s\e[0m\n' "${1}" "${2}"
}

print_success() {
  printf '\e[0;32m  [✔] %s\e[0m\n' "${1}"
}

# symlink
# -----------------------------------------------------------------------------
symlink() {
  local sourcepath="${DOTFILES}/${1}"
  local targetpath="${2}"
  local fulltargetpath="${HOME}/${targetpath}"

  # ensure the source exists
  [[ -e "${sourcepath}" ]] || die "${sourcepath} does not exist"

  if [[ -e "$fulltargetpath" ]]; then
    local rp
    rp=$(realpath "${fulltargetpath}")
    if [[ "$rp" == "${sourcepath}" ]]; then
      return
    fi

    echo "    ${targetpath} exists"
    read -p "          Overwrite? [y/N] " -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "    Skipped ${targetpath}"
      return
    fi
  fi

  echo -e "    Symlinking ${targetpath} \u279E ${sourcepath}"

  mkdir -p "$(dirname "${fulltargetpath}")"
  ln -fns "${sourcepath}" "${fulltargetpath}"
}

# install brew
# -----------------------------------------------------------------------------
install_homebrew() {
  if ! command -v brew >/dev/null; then
    announce_step "Installing Homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

# symlink files
# -----------------------------------------------------------------------------
symlink_files() {
  announce_step "Symlinking dotfiles"

  # vim
  symlink vim                  .vim
  symlink vim                  .config/nvim
  symlink vim/gvimrc           .gvimrc

  # ruby
  symlink ruby/irbrc           .irbrc
  symlink ruby/pryrc           .pryrc
  symlink ruby/gemrc           .gemrc
  symlink ruby/rspec           .rspec

  # git
  symlink git                  .config/git

  # go
  symlink go/gometalinter.json .config/gometalinter.json

  # javascript
  symlink node/tern-config     .tern-config

  # tmux
  symlink tmux/tmux.conf       .tmux.conf

  # screen
  symlink screen/screenrc      .screenrc

  # database
  symlink postgres             .config/pg
  symlink sqlite/sqliterc      .sqliterc

  # slate
  symlink slate/slate          .slate

  # shell
  symlink zsh/zshenv           .zshenv

  # search
  symlink ag/agignore          .agignore

  # ctags
  symlink ctags/ctags          .ctags

  # bookmarks
  symlink zsh/bookmarks        .config/bookmarks

  # bin
  symlink bin                  .local/bin

  print_success "Completed symlinks"
}

usage() {
  echo "${0} {brew, symlink}"
}

# -----------------------------------------------------------------------------
# main
# -----------------------------------------------------------------------------

# TODO terminfo
# TODO brew
# TODO macos defaults

main() {
  while (($# > 0)); do
    case "$1" in
      brew) install_homebrew ;;
      symlink) symlink_files ;;
      *) usage ;;
    esac
    shift
  done
}

main "$@"
