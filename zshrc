# ------------------------------------------------------------------------------
# zshrc
# ------------------------------------------------------------------------------

export ZSH=${ZDOTDIR:-${HOME}}/.zsh

zmodules=(zshmarks history-substring-search)
fpath=(${${zmodules}:+${ZSH}/modules/${^zmodules}/functions(/FN)} ${fpath})
autoload -Uz ${ZSH}/modules/${^zmodules}/functions/*(N:t)

autoload -Uz compinit; compinit
autoload -Uz bashcompinit; bashcompinit

for file (${ZSH}/*.zsh(N-.)); do
  source $file
done
unset file

for file (${ZSH}/modules/${^zmodules}/init.zsh(N-.)); do
  source $file
done
unset file

if [[ ! ${TERM} == (linux|*bsd*|dumb) ]]; then
  autoload -Uz promptinit && promptinit
  prompt areese
fi

hash -d --     docs=${HOME}/Documents
hash -d -- dotfiles=${HOME}/.dotfiles
hash -d --    gosrc=${GOPATH}/src
hash -d --   cellar=/usr/local/Cellar

# ------------------------------------------------------------------------------
[[ $ZSH_DEBUG ]] && zprof | less
# ------------------------------------------------------------------------------
# vi:ft=zsh
