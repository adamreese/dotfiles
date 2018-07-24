# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets

# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

typeset -A key
key[Delete]=$terminfo[kdch1]
key[Up]=$terminfo[kcuu1]
key[Down]=$terminfo[kcud1]
key[Left]=$terminfo[kcub1]
key[Right]=$terminfo[kcuf1]
key[ShiftTab]=$terminfo[kcbt]

bindkey -e                                            # Use emacs key bindings

bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
bindkey '^r'  history-incremental-search-backward     # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n $key[Up] ]]; then
  autoload -U             up-line-or-beginning-search
  zle      -N             up-line-or-beginning-search
  bindkey  "${key[Up]}"   up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${key[Down]}" ]]; then
  autoload -U             down-line-or-beginning-search
  zle      -N             down-line-or-beginning-search
  bindkey  "${key[Down]}" down-line-or-beginning-search
fi

bindkey ' '       magic-space                         # [Space] - do history expansion

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ -n "${key[ShiftTab]}" ]]; then
  bindkey "${key[ShiftTab]}" reverse-menu-complete    # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward
if [[ -n "${key[Delete]}" ]]; then
  bindkey "${key[Delete]}" delete-char                # [Delete] - delete forward
else
  bindkey "^[[3~"  delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~"  delete-char
fi

# Edit the current command line in $EDITOR
autoload -U         edit-command-line
zle      -N         edit-command-line
bindkey  '\C-x\C-e' edit-command-line

# file rename magick
bindkey  "^[m"      copy-prev-shell-word

#
# zsh-history-substring-search
#

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=yellow,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# bind UP and DOWN keys
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

# bind UP and DOWN arrow keys (compatibility fallback)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

zle-line-init zle-keymap-select() {
   VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
   RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1

# -----------------------------------------------------------------------------
# vim:ft=zsh
