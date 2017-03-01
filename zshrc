# ------------------------------------------------------------------------------
# zshrc
# ------------------------------------------------------------------------------

export ZSH=${ZDOTDIR:-${HOME}}/.zsh

autoload -Uz compinit; compinit
autoload -Uz bashcompinit; bashcompinit

for file (${ZSH}/*.zsh(N-.)); do
  source $file
done
unset file

if [[ ! ${TERM} == (linux|*bsd*|dumb) ]]; then
  autoload -Uz promptinit && promptinit
  prompt areese
fi

hash -d -- dotfiles=${HOME}/.dotfiles
hash -d --    gosrc=${GOPATH}/src
hash -d --   cellar=/usr/local/Cellar

source ${ZSH}/modules/zshmarks/init.zsh
source ${ZSH}/modules/history-substring-search/init.zsh

# ------------------------------------------------------------------------------
[[ $ZSH_DEBUG ]] && zprof | less
# ------------------------------------------------------------------------------
# vi:ft=zsh
