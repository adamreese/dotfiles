# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="areese"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.dotfiles/oh-my-zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git golang docker zshmarks history-substring-search)

source $ZSH/oh-my-zsh.sh

[[ -f "${HOME}/.aliases" ]] && source "${HOME}/.aliases"

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
for config (~/.zsh/configs/pre/*.zsh(N-.)) source $config
for config (~/.zsh/configs/*.zsh(N-.)) source $config
for config (~/.zsh/configs/post/*.zsh(N-.)) source $config

typeset -gU cdpath fpath manpath path

if (which zprof > /dev/null); then
  zprof | less
fi
