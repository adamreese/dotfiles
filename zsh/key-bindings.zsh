# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

if [[ ${TERM} == 'dumb' ]]; then
  return 1
fi

zmodload -F zsh/terminfo +b:echoti +p:terminfo
typeset -gA key_info
key_info=(
  'Control'      '\C-'
  'ControlLeft'  '\e[1;5D \e[5D \e\e[D \eOd \eOD'
  'ControlRight' '\e[1;5C \e[5C \e\e[C \eOc \eOC'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Space'        ' '
  'Backspace'    ${terminfo[kbs]}
  'ShiftTab'     ${terminfo[kcbt]}
  'Left'         ${terminfo[kcub1]}
  'Down'         ${terminfo[kcud1]}
  'Right'        ${terminfo[kcuf1]}
  'Up'           ${terminfo[kcuu1]}
  'Delete'       ${terminfo[kdch1]}
  'End'          ${terminfo[kend]}
  'F1'           ${terminfo[kf1]}
  'F2'           ${terminfo[kf2]}
  'F3'           ${terminfo[kf3]}
  'F4'           ${terminfo[kf4]}
  'F5'           ${terminfo[kf5]}
  'F6'           ${terminfo[kf6]}
  'F7'           ${terminfo[kf7]}
  'F8'           ${terminfo[kf8]}
  'F9'           ${terminfo[kf9]}
  'F10'          ${terminfo[kf10]}
  'F11'          ${terminfo[kf11]}
  'F12'          ${terminfo[kf12]}
  'Home'         ${terminfo[khome]}
  'Insert'       ${terminfo[kich1]}
  'PageDown'     ${terminfo[knp]}
  'PageUp'       ${terminfo[kpp]}
)

# Use emacs key bindings
bindkey -e

# [Esc-w] - Kill from the cursor to the mark
bindkey '\ew' kill-region

# [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey "$key_info[Control]R" history-incremental-search-backward

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n $key_info[Up] ]]; then
  autoload -U                up-line-or-beginning-search
  zle      -N                up-line-or-beginning-search
  bindkey  "${key_info[Up]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${key_info[Down]}" ]]; then
  autoload -U                  down-line-or-beginning-search
  zle      -N                  down-line-or-beginning-search
  bindkey  "${key_info[Down]}" down-line-or-beginning-search
fi

# [Space] - do history expansion
# bindkey ' '       magic-space

# [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey '^[[1;5D' backward-word

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${key_info[ShiftTab]}" ]]; then
  bindkey "${key_info[ShiftTab]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey '^?' backward-delete-char

# [Delete] - delete forward
if [[ -n "${key_info[Delete]}" ]]; then
  bindkey "${key_info[Delete]}" delete-char
else
  bindkey "^[[3~"  delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~"  delete-char
fi

# Edit the current command line in $EDITOR
autoload -U         edit-command-line
zle      -N         edit-command-line
bindkey  "$key_info[Control]X$key_info[Control]E" edit-command-line

# file rename magick
bindkey  '^[m'      copy-prev-shell-word

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
bindkey "$key_info[Control]X$key_info[Space]" expand-aliases
