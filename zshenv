# ------------------------------------------------------------------------------
# zshenv
# ------------------------------------------------------------------------------
[[ -n $ZSH_DEBUG ]] && zmodload zsh/zprof

# XDG Base Directory
# ------------------------------------------------------------------------------
# https://specifications.freedesktop.org/basedir-spec/latest
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

export ZSH="${ZDOTDIR:-${XDG_CONFIG_HOME}}/zsh"
export ZSH_CACHE="${XDG_CACHE_HOME}/zsh"

# Path
# ------------------------------------------------------------------------------
typeset -gU cdpath fpath manpath path

# load completion functions
fpath=(
  ${ZSH}/{completion,functions}(N-/)
  ${ZSH}/modules/*/{completion,functions}(N-/)
  /usr/local/share/zsh/site-functions(N-/)
  /usr/local/share/zsh-completions(N-/)
  ${fpath}
)
autoload -Uz ${ZSH}/functions/*(N:t)

path=(
  ${HOME}/.dotfiles/bin(N-/)
  ${HOME}/.local/bin(N-/)

  # GNU Coreutils
  /usr/local/opt/coreutils/libexec/gnubin(N-/)
  /usr/local/{bin,sbin}
  ${path}
)

manpath=(
  # GNU Coreutils
  /usr/local/opt/coreutils/libexec/gnuman(N-/)
  ${manpath}
)

# ------------------------------------------------------------------------------
# vi:ft=zsh
