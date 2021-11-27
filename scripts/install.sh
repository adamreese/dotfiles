#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || {
  echo "${DOTFILES} directory does not exist"
  exit 1
}

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
  (($# == 2)) || die 'symlink() requires 2 arguments'

  local source="${DOTFILES}/${1}"
  local target="${HOME}/${2}"

  # ensure the source exists
  [[ -e "${source}" ]] || die "${source} does not exist"

  if [[ -e "$target" ]]; then
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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

  # tmux
  symlink tmux/tmux.conf       .tmux.conf

  # screen
  symlink screen               .config/screen

  # hammerspoon
  symlink hammerspoon          .hammerspoon

  # shell
  symlink zsh/zshenv           .zshenv

  # search
  symlink ripgrep/ignore       .ignore

  # ctags
  symlink ctags                .config/ctags

  # bin
  symlink bin                  .local/bin

  # ranger
  symlink ranger               .config/ranger

  # yamllint
  symlink yamllint             .config/yamllint

  # bat
  symlink bat                  .config/bat

  # stylua
  symlink stylua               .config/stylua

  symlink karabiner            .config/karabiner

  print_success "Completed symlinks"
}

install_macos() {
  "${DOTFILES}/macos/defaults.sh"
}

usage() {
  echo "${0} brew|macos|symlink"
}

# -----------------------------------------------------------------------------
# main
# -----------------------------------------------------------------------------

# TODO terminfo
# TODO brew
# TODO macos defaults

main() {
  if (($# < 1)); then
    usage
    exit 1
  fi

  while (($# > 0)); do
    case "$1" in
      brew) install_homebrew ;;
      symlink) symlink_files ;;
      macos) install_macos ;;
      *) usage ;;
    esac
    shift
  done
}

main "$@"
