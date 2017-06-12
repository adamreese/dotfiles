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

# Path
# ------------------------------------------------------------------------------
typeset -gU cdpath fpath manpath path

# load completion functions
fpath=(
  ${XDG_CONFIG_HOME}/zsh/{completion,functions}(N-/)
  ${XDG_CONFIG_HOME}/zsh/modules/*/{completion,functions}(N-/)
  /usr/local/share/zsh/site-functions(N-/)
  /usr/local/share/zsh-completions(N-/)
  ${fpath}
)
autoload -Uz ${XDG_CONFIG_HOME}/zsh/functions/*(N:t)

path=(
  # mkdir .git/safe in the root of repositories you trust
  .git/safe/../../bin
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
