# zsh key bindings
# -----------------------------------------------------------------------------
[[ ${TERM} != 'dumb' ]] || return

# Vim mode
bindkey -v

# Time the shell waits for another key to be pressed
export KEYTIMEOUT=1

zmodload -i zsh/complist

# [Ctrl-A] and [Ctrl-E] Move to beginning/end of line
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# [Ctrl-P] and [Ctrl-N] Navigate history
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

# [Ctrl-U] Kill line backwards
bindkey '^U' backward-kill-line

# [Ctrl-W] Kill word backwards
bindkey '^W' backward-kill-word

# [Esc-W] Kill from the cursor to the mark
bindkey '\ew' kill-region

# [Ctrl-R] Search backward incrementally for a specified string
bindkey '^R' history-incremental-pattern-search-backward

# [Space] History expansion
bindkey ' ' magic-space

# [Backspace] Delete backward
bindkey '^?' backward-delete-char

# [Ctrl-X-E] Edit the current command line in $EDITOR
autoload -U     edit-command-line
zle      -N     edit-command-line
bindkey  '^X^E' edit-command-line

# [Shift-Tab] Move through the completion menu backwards
bindkey -M menuselect '^[[Z' reverse-menu-complete

# [Ctrl-C] Exit menu
bindkey -M menuselect '^C' reset-prompt

# Put into application mode and validate ${terminfo}
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  zle-line-init () {
    emulate -L zsh
    printf '%s' "${terminfo[smkx]}"
  }
  zle-line-finish () {
    emulate -L zsh
    printf '%s' "${terminfo[rmkx]}"
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# -----------------------------------------------------------------------------
# expand aliases

expand-aliases() {
  zle _expand_alias
  zle expand-word
  zle self-insert
}
zle -N expand-aliases

# [Control-x-Space] Global alias expansion
bindkey -M emacs '^x '  expand-aliases
bindkey -M emacs '^x^ ' expand-aliases

bindkey -M viins '^x '  expand-aliases
bindkey -M viins '^x^ ' expand-aliases

# -----------------------------------------------------------------------------

# automatically escape URLs
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# automatically quote URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic
