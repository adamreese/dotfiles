#!/usr/bin/env bash
set -euo pipefail

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
  local source="${DOTFILES}/${1}"
  local target="${HOME}/${2}"

  # ensure the source exists
  [[ -e "${source}" ]] || die "${source} does not exist"

  if [[ -e "$target" ]]; then
    local rp
    rp=$(realpath "${target}")
    if [[ "$rp" == "${source}" ]]; then
      return
    fi

    echo "    ${target} exists"
    read -p "          Overwrite? [y/N] " -r
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
      echo "    Skipped ${target}"
      return
    fi
  fi

  echo -e "    Symlinking ${target} \u279E ${source}"

  mkdir -p "$(dirname "${target}")"
  ln -fns "${source}" "${target}"
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

  # ruby
  symlink ruby/gemrc           .gemrc
  symlink ruby/rspec           .config/rspec/options

  # git
  symlink git                  .config/git

  # javascript
  symlink node/tern-config     .tern-config

  # tmux
  symlink tmux/tmux.conf       .tmux.conf

  # screen
  symlink screen               .config/screen

  # database
  symlink sqlite/sqliterc      .sqliterc

  # hammerspoon
  symlink hammerspoon          .hammerspoon

  # shell
  symlink zsh/zshenv           .zshenv

  # search
  symlink ag/agignore          .agignore

  # ctags
  symlink ctags/ctags          .ctags

  # bin
  symlink bin                  .local/bin

  # ranger
  symlink ranger               .config/ranger

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
