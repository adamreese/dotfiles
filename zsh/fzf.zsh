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
    --bind 'alt-p:preview-up,alt-n:preview-down'
    --bind 'alt-k:preview-up,alt-j:preview-down'
    --bind '?:toggle-preview'
    --preview-window 'right:62%:hidden'
  )
  typeset -gx FZF_DEFAULT_OPTS="${(f)_opts}"
}
