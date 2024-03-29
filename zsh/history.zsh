# zsh history
# -----------------------------------------------------------------------------

# Command history configuration
HISTFILE="${XDG_STATE_HOME}/zsh_history"
HISTSIZE=10000
SAVEHIST=10000

# Show history
alias history='fc -l 1'

# zsh options
# -----------------------------------------------------------------------------
setopt APPEND_HISTORY            # Append to $HISTFILE instead of replace
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file
setopt HIST_VERIFY               # Do not execute immediately upon history expansion
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits
setopt SHARE_HISTORY             # Share history between all sessions
