# vim: ft=zsh :

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--color=fg:15,bg:-1,bg+:-1,pointer:1,info:7,hl+:4,hl:4'

# Setup fzf
# ------------------------------------------------------------------------------
if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
  path+=("${HOME}/.fzf/bin")
fi

# Man path
# ------------------------------------------------------------------------------
if [[ ! "$MANPATH" == *${HOME}/.fzf/man* && -d "${HOME}/.fzf/man" ]]; then
  manpath+=("${HOME}/.fzf/man")
fi

# Auto-completion
# ------------------------------------------------------------------------------
[[ $- == *i* ]] && source "${HOME}/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------------------------------------------------------------------------
# source "${HOME}/.fzf/shell/key-bindings.zsh"
