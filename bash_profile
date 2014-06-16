#!/bin/bash

# bash_profile

DOTFILES="$HOME/.dotfiles"

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

  # Set a default ruby if a .ruby-version file exists in the home dir
  if [[ -f ~/.ruby-version ]]; then
    chruby $(cat ~/.ruby-version)
  fi
fi

## Perl
if [[ -s "$HOME/perl5/perlbrew/etc/bashrc" ]] ; then
  export PERLBREW_ROOT=$HOME/.perl5/perlbrew
  source "$HOME/.perl5/perlbrew/etc/bashrc"
fi

## set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/bin" ]] ; then
  PATH="$HOME/bin:$PATH"
fi

if [[ -d "$HOME/Developer" ]] ; then
  PATH="$HOME/Developer/bin:$PATH"
fi

## brewer path
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
source $(brew --prefix)/etc/bash_completion # Bash completion (installed via Homebrew)

if [[ -d "$HOME/Developer/lib/node_modules" ]] ; then
  NODE_PATH="$HOME/Developer/lib/node_modules"
fi

## source bash completions
if [[ -d "/usr/local/etc/bash_completion.d" ]] ; then
  source /usr/local/etc/bash_completion.d/*.bash
fi

# Git credentials
# Not under version control to prevent people from
# accidentally committing with your details
GIT_AUTHOR_NAME="adamreese"
GIT_AUTHOR_EMAIL="areese@engineyard.com"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

load_dotfiles() {
    declare -a files=(
        $HOME/.dotfiles/shell/aliases         # Aliases
        $HOME/.dotfiles/shell/bash_options    # Options
        $HOME/.dotfiles/shell/bash_exports    # Exports
        $HOME/.dotfiles/shell/functions/*     # Functions
        $HOME/.dotfiles/shell/bash_prompt     # Custom bash prompt
        $(brew --prefix)/etc/bash_completion  # Bash completion (installed via Homebrew)
    )

    # if these files are readable, source them
    for index in ${!files[*]}
    do
        if [[ -r ${files[$index]} ]]; then
            source ${files[$index]}
        fi
    done
}

load_dotfiles
unset load_dotfiles
