# zsh aliases
# -----------------------------------------------------------------------------

# masOS specific command aliases
[[ "${OSTYPE}" == darwin* ]] || return

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

# -----------------------------------------------------------------------------
# vim:ft=zsh
