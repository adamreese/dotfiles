# ------------------------------------------------------------------------------
# zshenv
# ------------------------------------------------------------------------------
[[ -n $ZSH_DEBUG ]] && zmodload zsh/zprof

typeset -gU cdpath fpath manpath path

# load completion functions
fpath=(
  ${HOME}/.zsh/{completion,functions}(N-/)
  ${HOME}/.zsh/modules/*/{completion,functions}(N-/)
  /usr/local/share/zsh/site-functions(N-/)
  /usr/local/share/zsh-completions(N-/)
  ${fpath}
)
autoload -Uz ${HOME}/.zsh/functions/*(N:t)

path=(
  # mkdir .git/safe in the root of repositories you trust
  .git/safe/../../bin
  ${HOME}/.dotfiles/bin(N-/)

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
