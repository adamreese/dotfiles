# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="areese"

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.dotfiles/oh-my-zsh

# Save the location of the current completion dump file.
ZSH_CACHE_DIR="${ZDOTDIR:-${HOME}}/.cache/zsh"

# ZSH_COMPDUMP="${ZSH_CACHE_DIR}/zcompdump"
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git docker zshmarks history-substring-search)

source $ZSH/oh-my-zsh.sh

if [[ -s "${HOME}/.aliases" ]]; then
  source "${HOME}/.aliases"
fi

for config_file (~/.zsh/configs/*.zsh(N-.)); do
  source $config_file
done
unset config_file

# ------------------------------------------------------------------------------
[[ $ZSH_DEBUG ]] && zprof | less
