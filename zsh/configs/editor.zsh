# vim: ft=zsh :

export VISUAL=vim
export EDITOR=$VISUAL

# Neovim
if (( $+commands[nvim] )); then
  export EDITOR=nvim

  export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

  alias vim='nvim'
  alias vimdiff='nvim -dO'
  alias view='nvim -R'
fi

# shortcut to EDITOR
v() {
  if [ $# -eq 0 ]; then
    $EDITOR .
  else
    $EDITOR "$@"
  fi
}

