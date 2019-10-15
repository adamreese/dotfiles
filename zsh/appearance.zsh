# ls colors

# # Enable ls colors
# export LSCOLORS='exfxcxdxbxegedabagacad'
# export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:'

if (( $+commands[dircolors] )); then
  if (( ! ${+LS_COLORS} )) && [[ -s ${XDG_CONFIG_HOME}/dircolors ]]; then
    eval "$(dircolors --sh ${XDG_CONFIG_HOME}/dircolors)"
  else
    export LS_COLORS='di=1;34:ln=35:so=32:pi=33:ex=31:bd=1;36:cd=1;33:su=30;41:sg=30;46:tw=30;42:ow=30;43'
  fi
fi

(( $+commands[gls] )) || alias gls='ls'

if gls --color > /dev/null 2>&1; then colorflag='--color'; else colorflag='-G'; fi;

alias ls="gls -Ah ${colorflag} --group-directories-first"
alias l='ls -l'

# Take advantage of $LS_COLORS for completion as well.
zstyle ':completion:*'         list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

[[ -n "$WINDOW" ]] && SCREEN_NO="%B$WINDOW%b " || SCREEN_NO=""
