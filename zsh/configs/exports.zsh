# vim: ft=zsh :

# Less
# ------------------------------------------------------------------------------

# i = case-insensitive searches, unless uppercase characters in search string
# F = exit immediately if output fits on one screen
# M = verbose prompt
# R = ANSI color support
# S = chop long lines (rather than wrap them onto next line)
# X = suppress alternate screen
export LESS='iFMRSX'

if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
