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
path+=(${fzf_root}/bin(N-/))

# Man path
# ------------------------------------------------------------------------------
manpath+=(${fzf_root}/man(N-/))

# Auto-completion
# ------------------------------------------------------------------------------
[[ $- == *i* ]] && source "${fzf_root}/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------------------------------------------------------------------------
# source "${fzf_root}/.fzf/shell/key-bindings.zsh"

unset fzf_root
