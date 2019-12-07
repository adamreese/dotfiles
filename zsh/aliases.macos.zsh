# zsh aliases
# -----------------------------------------------------------------------------

# masOS specific command aliases
[[ "${OSTYPE}" == darwin* ]] || return

# Show/hide hidden files in Finder
alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'

# Update and cleanup brew
alias     bubu='brew update && brew upgrade && brew cleanup -s'
alias    bubua='brew update && brew upgrade --fetch-HEAD && brew cleanup -s'
alias services='brew services'

# Flush dns cache
alias flush='sudo killall -HUP mDNSResponder'

alias video-reset='sudo killall AppleCameraAssistant;sudo killall VDCAssistant'
