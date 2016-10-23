# vim: ft=zsh :

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--color=fg:7,bg:-1,bg+:-1,pointer:1,info:7,hl+:4,hl:4'

# Setup fzf
# ------------------------------------------------------------------------------
if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
  export PATH="$PATH:${HOME}/.fzf/bin"
fi

# Man path
# ------------------------------------------------------------------------------
if [[ ! "$MANPATH" == *${HOME}/.fzf/man* && -d "${HOME}/.fzf/man" ]]; then
  export MANPATH="$MANPATH:${HOME}/.fzf/man"
fi

# Auto-completion
# ------------------------------------------------------------------------------
[[ $- == *i* ]] && source "${HOME}/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------------------------------------------------------------------------
# source "${HOME}/.fzf/shell/key-bindings.zsh"

fgo() {
  cd "${GOPATH}/src"
  DIR=$(print -l github.com/*/*(/) google.golang.org/*/*(/) k8s.io/*(/) rsprd.com/*(/) | fzf) && cd "$DIR"
}
