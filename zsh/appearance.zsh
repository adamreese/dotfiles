# ls colors
# ------------------------------------------------------------------------------

if (( ! ${+LS_COLORS} )) && [[ -s ${XDG_CONFIG_HOME}/dircolors ]]; then
  if (( $+commands[dircolors] )); then
    eval "$(dircolors --sh ${XDG_CONFIG_HOME}/dircolors)"
  elif (( $+commands[gdircolors] )); then
    eval "$(gdircolors --sh ${XDG_CONFIG_HOME}/dircolors)"
  fi
else
  export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi

(( ! $+commands[gls] )) || alias gls='ls'

if gls --color > /dev/null 2>&1; then colorflag='--color'; else colorflag='-G'; fi;

alias ls="gls -Ah ${colorflag} --group-directories-first --hyperlink=auto"
alias l='ls -l'

# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*'         list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
