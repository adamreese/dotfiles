# zsh aliases
# -----------------------------------------------------------------------------

# zinitup updates zinit and zsh plugins
alias zinitup='zinit self-update && zinit update --all --reset'

# Shortcuts
alias  c='clear'
alias  e='exit'
alias  q='exit'
alias :q='exit'

# FZF for browser bookmarks
alias b='browser-bookmarks'

# Switch to the previous directory
alias -- -='cd -'

# Allow aliases to be with sudo
alias sudo='sudo '

# Perform case insensitive matching
alias grep='grep -i --color=auto'

# ag
alias agp='ag --hidden --pager="less -iFMRSX"'
alias agh='ag --hidden'

# fd
alias fd="fd --hidden --ignore-file=${HOME}/.agignore "

# Git
alias   g='git'
alias glg='git log --stat'

# github
alias pr='hub pull-request'

# ghq
alias get='ghq get --update'

# IP addresses
alias pubip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en1'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# listening ports
alias ports='lsof +c 0 -iTCP -sTCP:LISTEN -n -P'

alias diga='dig +nocmd any +multiline +noall +answer'

# github.com/jocelynmallon/zshmarks
alias j='jump'

# ssh
alias sshtmp='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# kubectl
alias k=kubectl

# fun
alias lod='echo -n "ಠ_ಠ"'
alias idk='echo -n "¯\_(ツ)_/¯"'
alias wtf='echo -n "❨╯°□°❩╯︵┻━┻"'
alias wat='echo -n "⚆_⚆"'

# Global Aliases
# -----------------------------------------------------------------------------

alias -g ...='../..'
alias -g ....='../../..'

alias -g G='| grep'
alias -g L='| less'
alias -g S='| sort'
alias -g V='| nvim -'
