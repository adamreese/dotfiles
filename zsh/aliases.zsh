# zsh aliases
# -----------------------------------------------------------------------------

# Shortcuts
alias  c='clear'
alias  e='exit'
alias  q='exit'
alias :q='exit'

# Allow aliases to be with sudo
alias sudo='sudo '
alias apt-get='sudo apt-get'

# ls
alias ls='ls -pG'
alias ll='ls -lph'

# Perform case insensitive matching
alias grep='grep -i --color=auto'

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
alias ip='dig +short myip.opendns.com @resolver1.opendns.com'
alias localip='ipconfig getifaddr en1'
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# View logs
alias tfl='tail -Fn30 log/*.log'

# osx specific command aliases
if [[ $(uname -s) = "Darwin" ]]; then

  # bundle
  alias   be='bundle-exec-hack'
  alias   bi='bundle-hack install'
  alias   br='bundle-exec-hack rspec'
  alias  beg='bundle-exec-hack guard'
  alias  bil='bundle install --local'
  alias brff='bundle-exec-hack rspec --fail-fast'

  # Show/hide hidden files in Finder
  alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
  alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

  # Update and cleanup brew
  alias  bubu='brew update && brew upgrade && brew cleanup'
  alias bubua='brew update && brew upgrade --fetch-HEAD && brew cleanup'

  # Flush dns cache
  alias flush='sudo killall -HUP mDNSResponder'
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

 # fun
alias lod='echo "ಠ_ಠ"'
alias idk='echo "¯\_(ツ)_/¯"'
alias wtf='echo "❨╯°□°❩╯︵┻━┻"'
alias wat='echo "(☉_☉)"'

# -----------------------------------------------------------------------------
# vim:ft=zsh
