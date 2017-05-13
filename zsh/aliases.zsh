# zsh aliases
# -----------------------------------------------------------------------------
if [[ -s "${HOME}/.aliases" ]]; then
  source "${HOME}/.aliases"
fi

# Split comma or colin separated data onto separate lines
alias -g S="| tr ',:' '\n'"

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L='| less'
alias -g J='| jq .'

alias -g D='| diff-so-fancy | less --tabs=4 -RFX'

alias j='jump'

reload() {
  # remove all zcompiled files
  command rm -f ${ZDOTDIR:-${HOME}}/.{zshrc.zwc,zcompdump,zcompdump.zwc}(-.N)
  command rm -f ${ZSH}/**/*.zwc(-.N)

  # start again
  exec ${SHELL} -l
}

# -----------------------------------------------------------------------------
# vim:ft=zsh
