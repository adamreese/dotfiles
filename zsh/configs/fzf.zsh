# vim: ft=zsh :

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='
--color=fg:15,bg:-1,bg+:-1,pointer:1,info:7,hl+:4,hl:4
--bind=ctrl-u:page-up
--bind=ctrl-d:page-down
'

fzf_root="${HOME}/.fzf"

# Setup fzf
# ------------------------------------------------------------------------------
if [[ ! "$PATH" == *${fzf_root}/bin* ]]; then
  path+=("${fzf_root}/bin")
fi

# Man path
# ------------------------------------------------------------------------------
if [[ ! "$MANPATH" == *${fzf_root}/man* && -d "${fzf_root}/man" ]]; then
  manpath+=("${fzf_root}/man")
fi

# Auto-completion
# ------------------------------------------------------------------------------
[[ $- == *i* ]] && source "${fzf_root}/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------------------------------------------------------------------------
# source "${fzf_root}/.fzf/shell/key-bindings.zsh"
