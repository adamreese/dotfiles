# zsh fzf
# ------------------------------------------------------------------------------
(( ${+commands[fzf]} )) || return

typeset -gx FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
typeset -gx FZF_DEFAULT_OPTS='--color=fg:15,bg:-1,bg+:-1,pointer:1,info:7,hl+:4,hl:4 --multi --bind=ctrl-u:page-up,ctrl-d:page-down'
typeset -gx FZF_CTRL_T_OPTS='--select-1 --exit-0 --preview "(highlight -O ansi -l {} || cat {} || tree -C {}) 2> /dev/null | head -200" --bind "?:toggle-preview"'

# CTRL-T - Paste the selected file path(s) into the command line
__fsel() {
  setopt localoptions pipefail 2> /dev/null
  local opts="--height 40% --reverse ${FZF_DEFAULT_OPTS} ${FZF_CTRL_T_OPTS}"
  while read item; do
    echo -n "${(q)item} "
  done < <(eval "${FZF_DEFAULT_COMMAND} | $(__fzfcmd) ${opts} $@")
  local ret=$?
  echo
  return $ret
}

__fzfcmd() {
  ((${FZF_TMUX:-0} < 1)) && echo "fzf-tmux -d${FZF_TMUX_HEIGHT:-40%}" || echo "fzf"
}

widget-fzf-file() {
  LBUFFER="${LBUFFER}$(__fsel)"
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

# ------------------------------------------------------------------------------
# vim:ft=zsh
