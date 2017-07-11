# -----------------------------------------------------------------------------
# zsh directories
# -----------------------------------------------------------------------------

# Navigation
# -----------------------------------------------------------------------------
setopt AUTO_CD                   # Auto changes to a directory without typing cd.
setopt AUTO_PUSHD                # Push the old directory onto the stack on cd.
setopt CDABLE_VARS               # Change directory to a path stored in a variable.
setopt PUSHD_IGNORE_DUPS         # Do not store duplicates in the stack.
setopt PUSHD_MINUS               # Replace 'cd -' with 'cd +'
setopt PUSHD_SILENT              # Do not print the directory stack after pushd or popd.
setopt PUSHD_TO_HOME             # Push to home directory when no argument is given.

# Globbing
# -----------------------------------------------------------------------------
setopt EXTENDED_GLOB             # Use extended globbing syntax.
setopt MULTIOS                   # Write to multiple descriptors.
setopt NO_CLOBBER                # Disables overwrite existing files with `>`. Use `> | ` or `>!` instead
setopt GLOB_DOTS                 # Do not require a leading `.' in a filename to be matched explicitly.

# Aliases
# -----------------------------------------------------------------------------
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'

for index ({1..9}) alias "$index"="cd +${index}"; unset index

alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'

# List directory contents
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# -----------------------------------------------------------------------------
# vim:ft=zsh
