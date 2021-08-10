# zsh fzf
# ------------------------------------------------------------------------------
(( ${+commands[fzf]} )) || return

if (( ${+commands[fd]} )); then
  typeset -gx FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --no-ignore-vcs --exclude .git'
elif (( ${+commands[rg]} )); then
  typeset -gx FZF_DEFAULT_COMMAND='rg --files --hidden --no-messages --no-ignore-vcs --glob ""'
fi

function {
  local _opts=(
    --color 'fg:15,bg:-1,bg+:-1,pointer:1,info:7,hl+:4,hl:4'
    --multi
    --bind 'ctrl-u:page-up,ctrl-d:page-down'
    --bind '?:toggle-preview'
    --preview-window 'right:62%:hidden'
  )
  typeset -gx FZF_DEFAULT_OPTS="${(f)_opts}"
}

# Use ',' as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER=','

# ------------------------------------------------------------------------------

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

if [[ -s "/usr/local/opt/fzf/shell/completion.zsh" ]]; then
  source "/usr/local/opt/fzf/shell/completion.zsh"
fi

zle -N fzf-completion
bindkey -M viins '^I' fzf-completion

# [Ctrl-X /] fzf history
zle -N fzf-history-widget
bindkey -M viins '^X/' fzf-history-widget
bindkey -M emacs '^X/' fzf-history-widget
