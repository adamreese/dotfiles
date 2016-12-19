zstyle ':completion::complete:*' accept-exact '*(N)'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZSH_CACHE_DIR}"

# ignore completion functions for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '_*'
