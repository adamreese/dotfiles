# vim: ft=zsh :

# Split comma or colin separated data onto separate lines
alias -g S="| tr ',:' '\n'"

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"

zsh_compile() {
  autoload -Uz compinit zrecompile; compinit

  local zsh_sources=( zcompdump zshrc zsh/**/*.zsh(N-.))
  zsh_sources=(${ZDOTDIR:-${HOME}}/.${^zsh_sources})

  for f in ${zsh_sources}; do
    [[ "${f}" -nt "${f}.zwc" ]] && zrecompile -p "${f}" && command rm -f "${f}.zwc.old"
    [[ -s "${f}.zwc" ]] || zcompile $f
  done
}

reload() {
  command rm -f "${ZSH_COMPDUMP}" "${ZSH_COMPDUMP}.zwc"

  zsh_compile

  exec ${SHELL} -l
}
