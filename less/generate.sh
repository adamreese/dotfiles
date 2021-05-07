#!/usr/bin/env bash
set -euo pipefail

DOTFILES=${DOTFILES:-${HOME}/.dotfiles}
[[ -e "${DOTFILES}" ]] || { echo "${DOTFILES} directory does not exist" 1>&2; exit 1; }

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export LESSKEY=${LESSKEY:-${XDG_CONFIG_HOME}/less/less}

mkdir -p "${XDG_CONFIG_HOME}/less"

lesskey "${DOTFILES}/less/lesskey"
