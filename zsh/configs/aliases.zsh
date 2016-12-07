# vim: ft=zsh :

# Split comma or colin separated data onto separate lines
alias -g S="| tr ',:' '\n'"

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"


reload() {
  rm -f "${ZSH_COMPDUMP}" "${ZSH_COMPDUMP}.zwc"
  exec ${SHELL} -l
}
