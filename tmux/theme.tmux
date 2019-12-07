#!/usr/bin/env tmux

# command/message line
set-option -g message-fg colour3
set-option -g message-bg black
set-option -g message-attr none

# amount of time for which status line messages and other indicators
# are displayed. time is in milliseconds.
set-option -g display-time 2000


# set-option -g pane-border-status bottom
set-option -g pane-border-format '-'
# set-option -g pane-active-border-fg black
# set-option -g pane-active-border-bg default

# default statusbar colors
set-option -g status-fg default
set-option -g status-bg default
set-option -g status-attr dim
set-option -g status-position bottom
set-option -g status-justify left

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
set-window-option -g window-status-fg colour7
set-window-option -g window-status-format ' #I:#W '

# active window title colors
set-window-option -g window-status-current-fg colour2
set-window-option -g window-status-current-format ' #I:#W '

# set-option -g status-left '#[fg=colour240][ #[fg=colour7]#S #[fg=colour240]] '
set-option -g status-left ''
set-option -g status-left-length '100'
set-option -g status-right-length '100'
set-window-option -g window-status-separator ' '

set-option -g status-right '#[fg=colour3]#S#[fg=default] [ #[fg=colour243]#I:#P#[fg=default] ]'

# -----------------------------------------------------------------------------
# vim:ft=tmux
