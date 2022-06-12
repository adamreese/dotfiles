# zsh gpg
# -----------------------------------------------------------------------------
export GPG_TTY="${TTY}"

if [[ -d '/usr/local/MacGPG2/bin' ]]; then
  path+='/usr/local/MacGPG2/bin'
fi

(( $+commands[gpg-agent] )) || return

gpg-refresh-agent() {
  gpg-connect-agent updatestartuptty /bye >/dev/null
}

# Set SSH to use gpg-agent if it is configured to do so
if grep -q '^enable-ssh-support' $HOME/.gnupg/gpg-agent.conf 2>/dev/null; then
  unset SSH_AGENT_PID
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Disable GUI prompts inside SSH.
if [[ -n "$SSH_CONNECTION" ]]; then
  export PINENTRY_USER_DATA='USE_CURSES=1'
fi
