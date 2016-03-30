#
# Defines environment variables.
#

export OS=`uname -s`
export ARCH=`uname -m`

# Browser

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Editors

export EDITOR='vim'
export VISUAL='mvim'
export PAGER='less'

# Language

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi


# Paths

typeset -gU cdpath fpath mailpath path

export GOPATH=$HOME/p/go
export GO15VENDOREXPERIMENT=1

fpath=(~/.zsh/completion $fpath)

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  ~/.dotfiles/bin
  $GOPATH/bin
  /usr/local/{bin,sbin}
  ~/.perl5/perlbrew/bin
  $path
)

# Less

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

# Temporary Files

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi

## Perl
if [[ -s "$HOME/.perl5/perlbrew/etc/bashrc" ]] ; then
  source "$HOME/.perl5/perlbrew/etc/bashrc"
fi

skip_global_compinit=1
