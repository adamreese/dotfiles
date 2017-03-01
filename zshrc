# ------------------------------------------------------------------------------
# zshrc
# ------------------------------------------------------------------------------

export ZSH=${ZDOTDIR:-${HOME}}/.zsh

autoload -Uz compinit; compinit
autoload -Uz bashcompinit; bashcompinit

for config_file (${ZSH}/*.zsh(N-.)); do
  source $config_file
done
unset config_file

if [[ ! ${TERM} == (linux|*bsd*|dumb) ]]; then
  autoload -Uz promptinit && promptinit
  prompt areese
fi

hash -d -- dotfiles=${HOME}/.dotfiles
hash -d --    gosrc=${GOPATH}/src
hash -d --   cellar=/usr/local/Cellar

# ------------------------------------------------------------------------------
[[ $ZSH_DEBUG ]] && zprof | less
# ------------------------------------------------------------------------------
# vi:ft=zsh
