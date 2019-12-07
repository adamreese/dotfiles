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

bindkey -e                                            # Use emacs key bindings

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey "$key_info[Control]R" history-incremental-search-backward     # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n $key_info[Up] ]]; then
  autoload -U             up-line-or-beginning-search
  zle      -N             up-line-or-beginning-search
  bindkey  "${key_info[Up]}"   up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${key_info[Down]}" ]]; then
  autoload -U             down-line-or-beginning-search
  zle      -N             down-line-or-beginning-search
  bindkey  "${key_info[Down]}" down-line-or-beginning-search
fi

bindkey ' '       magic-space                         # [Space] - do history expansion

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ -n "${key_info[ShiftTab]}" ]]; then
  bindkey "${key_info[ShiftTab]}" reverse-menu-complete    # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ -n "${key_info[Delete]}" ]]; then
  bindkey "${key_info[Delete]}" delete-char                # [Delete] - delete forward
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

# Redisplay after completing, and avoid blank prompt after <Tab><Tab><Ctrl-C>
expand-or-complete-with-redisplay() {
  print -Pn '⋯'
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-redisplay
bindkey "${key_info[Control]}I" expand-or-complete-with-redisplay

# ------------------------------------------------------------------------------
# zsh-history-substring-search

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# bind UP and DOWN keys
bindkey "$key_info[Up]" history-substring-search-up
bindkey "$key_info[Down]" history-substring-search-down

zle-line-init zle-keymap-select() {
   VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
   RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1

# Put into application mode and validate ${terminfo}
zle-line-init() {
  (( ${+terminfo[smkx]} )) && echoti smkx
}
zle-line-finish() {
  (( ${+terminfo[rmkx]} )) && echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish
