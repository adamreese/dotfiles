# load our own completion functions
fpath+=(
  ${HOME}/.zsh/{completion,functions}(N-/)
  /usr/local/share/zsh/site-functions(N-/)
)

autoload -U ${HOME}/.zsh/functions/*(:t)

# Create a cache directory if it doesn't exist.
if [ ! -d "${ZDOTDIR:-${HOME}}/.cache/zsh" ]; then
  mkdir -p "${ZDOTDIR:-${HOME}}/.cache/zsh"
fi

# Force starting compinit as early as possible
autoload -Uz compinit
compinit -i -d "$ZSH_COMPDUMP"

function compinit { }

