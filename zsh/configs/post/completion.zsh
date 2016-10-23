# make autocompletion faster by caching and prefix-only matching
zstyle ':completion:*'           accept-exact '*(N)'
zstyle ':completion::complete:*' accept-exact '*(N)'
zstyle ':completion:*'           use-cache on
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*'           cache-path ~/.zsh/cache
zstyle ':completion::complete:*' cache-path ~/.zsh/cache

# ignore completion functions for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '_*'
