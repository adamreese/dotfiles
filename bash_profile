#!/bin/bash

# bash_profile

# set 256 color profile where possible
if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

## Chruby
if [[ -d "/usr/local/share/chruby" ]] ; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby-2.3
fi

## set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/bin" ]] ; then
  PATH="$HOME/bin:$PATH"
fi

## brewer path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

## source bash completions
if [[ -d "/usr/local/etc/bash_completion.d" ]] ; then
  source /usr/local/etc/bash_completion.d/*.bash
fi

source $HOME/.aliases                 # Aliases
source $HOME/.dotfiles/bash_prompt    # Custom bash prompt
