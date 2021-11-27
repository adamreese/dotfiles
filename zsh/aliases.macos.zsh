# zsh aliases
# -----------------------------------------------------------------------------

# masOS specific command aliases
[[ "${OSTYPE}" == darwin* ]] || return

# Update and cleanup brew
alias     bubu='brew update && brew upgrade && brew cleanup -s'
alias    bubua='brew update && brew upgrade --fetch-HEAD && brew cleanup -s'
alias services='brew services'

# Flush dns cache
alias flush='sudo killall -HUP mDNSResponder'

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Airport CLI alias
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
