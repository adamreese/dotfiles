# zsh environment
# -----------------------------------------------------------------------------

# General
# -----------------------------------------------------------------------------
setopt BRACE_CCL            # Allow brace character class list expansion.
setopt COMBINING_CHARS      # Combine zero-length punctuation characters (accents) with the base character.
setopt RC_QUOTES            # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
setopt IGNORE_EOF           # Disable '^D' logout keybind
setopt INTERACTIVE_COMMENTS # allow the use of `# ` in the command line
setopt NO_MAIL_WARNING      # Don't print a warning message if a mail file has been accessed.
setopt NO_CORRECT           # Disable zsh correct

# Jobs
# -----------------------------------------------------------------------------
setopt LONG_LIST_JOBS       # List jobs in the long format by default.
setopt AUTO_RESUME          # Attempt to resume existing job before creating a new process.
setopt NOTIFY               # Report status of background jobs immediately.
setopt NO_BG_NICE           # Don't run all background jobs at a lower priority.
setopt NO_HUP               # Don't kill jobs on shell exit.
setopt NO_CHECK_JOBS        # Don't report on jobs when shell exit.

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

if [[ -d /usr/local/share/zsh/help ]]; then
  unalias run-help
  autoload run-help
  HELPDIR=/usr/local/share/zsh/help
fi

# Editor
# -----------------------------------------------------------------------------
export EDITOR=vim
export VISUAL=${EDITOR}

# Neovim
if (( $+commands[nvim] )); then
  export EDITOR=nvim

  alias vim='nvim'
  alias vimdiff='nvim -dO'
  alias view='nvim -R'
fi

# -----------------------------------------------------------------------------
# vim:ft=zsh