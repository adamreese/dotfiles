# load our own completion functions
fpath+=(
  ${HOME}/.zsh/{completion,functions}(N-/)
  /usr/local/share/zsh/site-functions(N-/)
)

autoload -U ${HOME}/.zsh/functions/*(:t)


# Create a cache directory if it doesn't exist.
if [ ! -d "${ZDOTDIR:-${HOME}}/.zsh/cache" ]; then
  mkdir -p "${ZDOTDIR:-${HOME}}/.zsh/cache"
fi

# Force starting compinit as early as possible
autoload -Uz compinit && compinit -d "$ZSH_COMPDUMP"

function compinit { }

