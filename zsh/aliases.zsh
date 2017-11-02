# zsh aliases
# -----------------------------------------------------------------------------

# Shortcuts
alias  c='clear'
alias  e='exit'
alias  q='exit'
alias :q='exit'

alias -- -='cd -'

# Allow aliases to be with sudo
alias sudo='sudo '
alias apt-get='sudo apt-get'

# Perform case insensitive matching
alias grep='grep -i --color=auto'

# Safety first
alias rm='rm -iv'

# ag
alias agp='ag --pager="less -iFMRSX"'
alias agh='ag --hidden'

# Git
alias   g='git'
alias glg='git log --stat'

# github
alias gh='hub browse'
alias pr='hub pull-request'

# ghq
alias get='ghq get --update'

# IP addresses
alias pubip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en1'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# View logs
alias tfl='tail -Fn30 log/*.log'

# github.com/jocelynmallon/zshmarks
alias j='jump'

# aliases inside tmux session
if [[ $TERM == *"tmux"* ]]; then
  alias :sp='tmux split-window'
  alias :vs='tmux split-window -h'
fi

# fun
alias lod='echo "ಠ_ಠ"'
alias idk='echo "¯\_(ツ)_/¯"'
alias wtf='echo "❨╯°□°❩╯︵┻━┻"'
alias wat='echo "⚆_⚆"'

# Global Aliases
# -----------------------------------------------------------------------------

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# Split comma or colin separated data onto separate lines
alias -g S="| tr ',:' '\n'"

alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L='| less'
alias -g J='| jq .'

alias -g D='| diff-so-fancy | less --tabs=4 -RFX'

# zreload shell and completion
zreload() {
  # remove all zcompiled files
  command rm -f ${ZDOTDIR:-${HOME}}/.{zshrc.zwc,zcompdump,zcompdump.zwc}(-.N)
  command rm -f ${ZSH}/**/*.zwc(-.N)

  # start again
  exec ${SHELL} -l
}

# -----------------------------------------------------------------------------
# vim:ft=zsh
