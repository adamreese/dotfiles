# zsh fzf
# ------------------------------------------------------------------------------
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

_fzf_opts=(
  --color=fg:15,bg:-1,bg+:-1,pointer:1,info:7,hl+:4,hl:4
  --bind=ctrl-u:page-up
  --bind=ctrl-d:page-down
)
export FZF_DEFAULT_OPTS="${_fzf_opts}"

unset _fzf_opts

# Setup FZF paths
# ------------------------------------------------------------------------------
path+=(${HOME}/.fzf/bin(N-/))
manpath+=(${HOME}/.fzf/man(N-/))

# Completion
# ------------------------------------------------------------------------------
[[ $- == *i* ]] && source "${HOME}/.fzf/shell/completion.zsh" 2> /dev/null

# ------------------------------------------------------------------------------
# vim:ft=zsh
