#!/usr/bin/env bash

# Bash 'Strict Mode'
# http://redsymbol.net/articles/unofficial-bash-strict-mode
set -euo pipefail
IFS=$'\n\t'

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -a "${DOTFILES}" ]] || die "${DOTFILES} directory does not exist"

# die
# -----------------------------------------------------------------------------
die() {
  # ${BASH_SOURCE[1]} is the file name of the caller.
  local error="${1:-Unknown Error.}"
  local code="${2:-1}"
  printf >&2 "\e[0;31m  [✖] %s:%s: %s (exit %s)\e[0m\n" \
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
  echo -e "\033[0;32m \u279E   \033[0;0m $*"
}

print_error() {
  printf "\e[0;31m  [✖] %s %s\e[0m\n" "${1}" "${2}"
}

print_success() {
  printf "\e[0;32m  [✔] %s\e[0m\n" "${1}"
}

# symlink
# -----------------------------------------------------------------------------
symlink() {
  local sourcepath="${DOTFILES}/${1}"
  local targetpath="${2}"
  local fulltargetpath="${HOME}/${targetpath}"

  # ensure the source exists
  [[ -a "${sourcepath}" ]] || die "${sourcepath} does not exist"

  if [[ -a "$fulltargetpath" ]]; then
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
  symlink tmux.conf            .tmux.conf

  # screen
  symlink screenrc             .screenrc

  # database
	symlink psqlrc               .psqlrc
	symlink sqliterc             .sqliterc

  # slate
	symlink slate                .slate

  # shell
  symlink aliases              .aliases
  symlink zsh/zlogin           .zlogin
  symlink zsh/zlogout          .zlogout
  symlink zsh/zshrc            .zshrc
  symlink zsh                  .config/zsh

  # search
  symlink ackrc                .ackrc
  symlink agignore             .agignore

  # ctags
  symlink ctags                .ctags

  # bookmarks
  symlink bookmarks            .bookmarks

  # bin
  symlink bin                  .local/bin

  print_success "Completed symlinks"
}

install_python_packages() {
  echo "Updating global pip"
  pip3 install --upgrade pip

  echo "Updating global pip requirements"
  pip3 install --upgrade --requirement "${DOTFILES}/python/requirements.txt"
}

install_ruby_gems() {
  echo "Installing default gems"
  while read -r gemname; do
    gem install "$gemname"
  done < "${DOTFILES}/ruby/default-gems"
}

install_go_packages() {
  echo "Installing default go packages"
  while read -r pkg; do
    echo "${pkg}"
    go get -u "${pkg}"
  done < "${DOTFILES}/go/default-packages"
}

install_node_packages() {
  echo "Installing default node packages"
  while read -r pkg; do
    echo "${pkg}"
    npm install --global --production "${pkg}"
  done < "${DOTFILES}/node/default-packages"
}

usage() {
  echo "${0} {brew, go, python, ruby, node, symlink}"
}

# -----------------------------------------------------------------------------
# main
# -----------------------------------------------------------------------------

# TODO terminfo
# TODO brew
# TODO macos defaults

main() {
  while (( "$#" > 0 )); do
    case "$1" in
      brew)    install_homebrew        ;;
      go)      install_go_packages     ;;
      python)  install_python_packages ;;
      ruby)    install_ruby_gems       ;;
      node)    install_node_packages   ;;
      symlink) symlink_files           ;;
      *)       usage                   ;;
    esac
    shift
  done
}

main "$@"
