# zsh aliases
# -----------------------------------------------------------------------------

# zinitup updates zinit and zsh plugins
alias zinitup='zinit self-update && zinit update --all --reset'

# Shortcuts
alias  c='clear'
alias  e='exit'
alias  q='exit'
alias :q='exit'

# Switch to the previous directory
alias -- -='cd -'

# Allow aliases to be with sudo
alias sudo='sudo '

# Perform case insensitive matching
alias grep='grep -i --color=auto'

# ag
alias agp='ag --hidden --pager="less -iFMRSX"'
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

alias diga='dig +nocmd any +multiline +noall +answer'

# github.com/jocelynmallon/zshmarks
alias j='jump'

# bundle
alias   be='bundle-exec-hack'
alias   bi='bundle-hack install'
alias   br='bundle-exec-hack rspec'
alias  beg='bundle-exec-hack guard'
alias  bil='bundle install --local'
alias brff='bundle-exec-hack rspec --fail-fast'

# ssh
alias sshtmp='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

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

alias -g G='| grep'
alias -g H='| head'
alias -g J='| jq .'
alias -g L='| less'
alias -g T='| tail'
