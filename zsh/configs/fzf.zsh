# vim: ft=zsh :

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--color=16,bg:-1,fg:-1,bg+:0,fg+:7,hl:12,hl+:3'

# Setup fzf
# ------------------------------------------------------------------------------
if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
  export PATH="$PATH:${HOME}/.fzf/bin"
fi

# Man path
# ------------------------------------------------------------------------------
if [[ ! "$MANPATH" == *${HOME}/.fzf/man* && -d "${HOME}/.fzf/man" ]]; then
  export MANPATH="$MANPATH:${HOME}/.fzf/man"
fi

# Auto-completion
# ------------------------------------------------------------------------------
[[ $- == *i* ]] && source "${HOME}/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------------------------------------------------------------------------
# source "${HOME}/.fzf/shell/key-bindings.zsh"
