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
(( $+commands[ggrep] )) || alias ggrep='ls'
alias grep='ggrep -i --color=auto'

# fd
alias fd="fd --hidden --ignore-file=${DOTFILES}/ripgrep/ignore "

# Git
alias   g='git'
alias glg='git log --stat'

# ghq
alias get='ghq get --update'

# IP addresses
alias pubip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en1'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# listening ports
alias ports='lsof +c0 -iTCP -sTCP:LISTEN -n -P'

# github.com/jocelynmallon/zshmarks
alias j='jump'

# ssh
alias sshtmp='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# kubectl
alias k=kubectl

# fun
alias lod='echo -n "ಠ_ಠ"'
alias idk='echo -n "¯\_(ツ)_/¯"'
alias huh='echo -n "¯\_(°ペ)_/¯"'
alias wtf='echo -n "❨╯°□°❩╯︵┻━┻"'
alias wat='echo -n "⚆_⚆"'
alias wftpanda='echo -n "ʕノ•ᴥ•ʔノ ︵"'

# view images in kitty
alias icat='kitten icat'

# Global Aliases
# -----------------------------------------------------------------------------

alias -g ...='../..'
alias -g ....='../../..'

alias -g G='| grep'
alias -g L='| less'
alias -g S='| sort'
alias -g V='| nvim -'
