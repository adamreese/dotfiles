# zsh environment
# -----------------------------------------------------------------------------

# Input/Output
# -----------------------------------------------------------------------------
unsetopt CLOBBER               # Disables overwrite existing files with `>`. Use `> | ` or `>!` instead
unsetopt CORRECT               # Disable zsh correct
unsetopt FLOW_CONTROL          # Disable start/stop characters in shell editor.
setopt   IGNORE_EOF            # Disable '^D' logout keybind
setopt   INTERACTIVE_COMMENTS  # allow the use of `# ` in the command line
unsetopt MAIL_WARNING          # Don't print a warning message if a mail file has been accessed.
setopt   PATH_DIRS             # Perform path search even on command names with slashes.
setopt   RC_QUOTES             # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.

# Jobs
# -----------------------------------------------------------------------------
setopt   AUTO_RESUME           # Attempt to resume existing job before creating a new process.
unsetopt BG_NICE               # Don't run all background jobs at a lower priority.
unsetopt CHECK_JOBS            # Don't report on jobs when shell exit.
unsetopt HUP                   # Don't kill jobs on shell exit.
setopt   LONG_LIST_JOBS        # List jobs in the long format by default.
setopt   NOTIFY                # Report status of background jobs immediately.

# Expansion and Globbing
# -----------------------------------------------------------------------------
setopt   BRACE_CCL             # Allow brace character class list expansion.
unsetopt CASE_GLOB             # Make globbing (filename generation) sensitive to case.
setopt   EXTENDED_GLOB         # Use extended globbing syntax.
setopt   GLOB_DOTS             # Do not require a leading `.' in a filename to be matched explicitly.
setopt   MULTIOS               # Write to multiple descriptors.

# Navigation
# -----------------------------------------------------------------------------
setopt   AUTO_CD               # Auto changes to a directory without typing cd.
setopt   AUTO_PUSHD            # Push the old directory onto the stack on cd.
setopt   CDABLE_VARS           # Change directory to a path stored in a variable.
setopt   PUSHD_IGNORE_DUPS     # Do not store duplicates in the stack.
setopt   PUSHD_MINUS           # Replace 'cd -' with 'cd +'
setopt   PUSHD_SILENT          # Do not print the directory stack after pushd or popd.
setopt   PUSHD_TO_HOME         # Push to home directory when no argument is given.

# ZLE
# -----------------------------------------------------------------------------
setopt   COMBINING_CHARS       # Combine zero-length punctuation characters (accents) with the base character.

# Less
# ------------------------------------------------------------------------------
#            ┌─ i: case-insensitive searches, unless uppercase characters in search string
#            │┌─ F: exit immediately if output fits on one screen
#            ││┌─ K: exit on CTRL-C
#            │││┌─ M: verbose prompt
#            ││││┌─ R: ANSI color support
#            │││││┌─ X: suppress alternate screen
export LESS='iFKMRX'
# disable less history
export LESSHISTFILE=${XDG_DATA_HOME}/less/history
export LESSKEY=${XDG_CONFIG_HOME}/less/less

if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Editor
# -----------------------------------------------------------------------------
export EDITOR=vim

# Neovim
if (( $+commands[nvim] )); then
  export EDITOR=nvim

  alias     vim='nvim'
  alias    view='nvim -R'
  alias vimdiff='nvim -dO'
fi

export VISUAL=${EDITOR}
