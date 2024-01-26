#!/usr/bin/env tmux

# command/message line
set-option -g message-style fg=colour3,bg=black,none

# amount of time for which status line messages and other indicators
# are displayed. time is in milliseconds.
set-option -g display-time 2000


# set-option -g pane-border-status bottom
set-option -g pane-border-format '-'
# set-option -g pane-active-border-fg black
# set-option -g pane-active-border-bg default

# default statusbar colors
set-option -g status-position bottom
set-option -g status-justify left
set-option -g status-style fg=default,bg=default,dim

# "I' == current window index
# 'H' == Hostname
# 'F' == current window flag
# 'P' == current pane index
# 'S' == Session name
# 'T' == current window title
# 'W' == current window name
# '#' == a literal "#"
# Where appropriate, special character sequences may be prefixed with a
# number to specify the maximum length, in this line "#10W'.

# default window title colors
set-option -g window-status-format ' #[fg=colour7]#I:#W#[fg=default] '

# active window title colors
set-option -g window-status-current-format ' #[fg=colour2]#I:#W#[fg=default] '

# set-option -g status-left '#[fg=colour240][ #[fg=colour7]#S #[fg=colour240]] '
set-option -g status-left ''
set-option -g status-left-length '100'
set-option -g status-right-length '100'
set-window-option -g window-status-separator ' '

set -g @prefix_highlight_output_prefix ''
set -g @prefix_highlight_output_suffix ' '
set -g @prefix_highlight_fg 'black' # default is 'colour231'
set -g @prefix_highlight_bg 'green'  # default is 'colour04'
set -g @prefix_highlight_prefix_prompt 'Wait'
set -g @prefix_highlight_copy_prompt 'Copy'
set -g @prefix_highlight_sync_prompt 'Sync'

set-option -g status-right '#{prefix_highlight} #[fg=colour3]#S#[fg=default] [ #[fg=colour243]#I:#P#[fg=default] ]'

# -----------------------------------------------------------------------------
# vim:ft=tmux
