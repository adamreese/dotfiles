#
# Defines environment variables.
#

export OS=`uname -s`
export ARCH=`uname -m`

# Browser

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# Paths

typeset -gU cdpath fpath mailpath path

fpath=(${HOME}/.zsh/completion  /usr/local/share/zsh-completions "${fpath[@]}")

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
# path=(
#   $path
# )

# Temporary Files

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$USER"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
if [[ ! -d "$TMPPREFIX" ]]; then
  mkdir -p "$TMPPREFIX"
fi

#skip_global_compinit=1
