#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || {
  echo "${DOTFILES} directory does not exist"
  exit 1
}

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

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

# symlink files
# -----------------------------------------------------------------------------
symlink_files() {
  announce_step "Symlinking dotfiles"

  # vim
  symlink vim                  .config/nvim

  # ruby
  symlink ruby/gemrc           .gemrc
  symlink ruby/rspec           .config/rspec/options

  symlink git                  .config/git
  symlink tmux                 .config/tmux
  symlink screen               .config/screen
  symlink zsh/zshenv           .zshenv
  symlink ripgrep/ignore       .ignore
  symlink ctags                .config/ctags
  symlink bin                  .local/bin
  symlink ranger               .config/ranger
  symlink yamllint             .config/yamllint
  symlink bat                  .config/bat
  symlink stylua               .config/stylua

  if [[ "${OSTYPE}" == darwin* ]]; then
    symlink hammerspoon          .hammerspoon
    symlink karabiner            .config/karabiner
  fi

  print_success "Completed symlinks"
}

install_macos() {
  "${DOTFILES}/macos/install.sh"
  "${DOTFILES}/macos/defaults.sh"
}

preflight() {
  # ensure xdg directories
  mkdir -p "${XDG_CACHE_HOME}"
  mkdir -p "${XDG_CONFIG_HOME}"
  mkdir -p "${XDG_DATA_HOME}"
  mkdir -p "${XDG_STATE_HOME}"
}

usage() {
  echo "${0} macos|symlink"
}

# -----------------------------------------------------------------------------
# main
# -----------------------------------------------------------------------------

# TODO terminfo
# TODO macos defaults

main() {
  if (($# < 1)); then
    usage
    exit 1
  fi

  preflight

  while (($# > 0)); do
    case "$1" in
      symlink) symlink_files ;;
      macos) install_macos ;;
      *) usage ;;
    esac
    shift
  done
}

main "$@"
