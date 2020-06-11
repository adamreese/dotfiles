# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

if [[ ${TERM} == 'dumb' ]]; then
  return
fi

# Use emacs key bindings
bindkey -e

# [Esc-w] - Kill from the cursor to the mark
bindkey '\ew' kill-region

# [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey '^[R' history-incremental-search-backward

# [Space] - do history expansion
bindkey ' ' magic-space

# [Backspace] - delete backward
bindkey '^?' backward-delete-char

# Edit the current command line in $EDITOR
autoload -U     edit-command-line
zle      -N     edit-command-line
bindkey  '^X^E' edit-command-line

zmodload -i zsh/complist

# [Shift-Tab] - move through the completion menu backwards
bindkey -M menuselect '^[[Z' reverse-menu-complete

# [Ctrl-C] - exit menu
bindkey -M menuselect '^C' reset-prompt

export KEYTIMEOUT=1

# Put into application mode and validate ${terminfo}
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  zle-line-init () {
    printf '%s' "${terminfo[smkx]}"
  }
  zle-line-finish () {
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

# [Control-x-Space] - do global alias expansion
bindkey '^X^ ' expand-aliases
