# zsh fzf
# ------------------------------------------------------------------------------
(( ${+commands[fzf]} )) || return

if (( ${+commands[fd]} )); then
  typeset -gx FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
else
  typeset -gx FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
fi
typeset -gx FZF_DEFAULT_OPTS='--color=fg:15,bg:-1,bg+:-1,pointer:1,info:7,hl+:4,hl:4 --multi --bind=ctrl-u:page-up,ctrl-d:page-down'
typeset -gx FZF_CTRL_T_OPTS='--select-1 --exit-0 --preview "(highlight -O ansi -l {} || cat {} || tree -C {}) 2> /dev/null | head -200" --bind "?:toggle-preview"'

export FZF_COMPLETION_TRIGGER='``'

# CTRL-T - Paste the selected file path(s) into the command line
fzf-sel() {
  setopt localoptions pipefail 2> /dev/null
  local opts="--height 40% --reverse ${FZF_DEFAULT_OPTS} ${FZF_CTRL_T_OPTS}"
  while read item; do
    echo -n "${(q)item} "
  done < <(eval "${FZF_DEFAULT_COMMAND} | fzf ${opts} $@")
  local ret=$?
  echo
  return $ret
}

widget-fzf-file() {
  LBUFFER="${LBUFFER}$(fzf-sel)"
  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   widget-fzf-file
bindkey '^T' widget-fzf-file

widget-fzf-branch() {
  if git rev-parse --git-dir &>/dev/null; then
    git-fco
    zle accept-line
  fi
}
zle     -N   widget-fzf-branch
bindkey '^B' widget-fzf-branch

if [[ -s "/usr/local/opt/fzf/shell/completion.zsh" ]]; then
  source "/usr/local/opt/fzf/shell/completion.zsh"
fi
