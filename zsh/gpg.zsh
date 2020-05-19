# zsh gpg
# -----------------------------------------------------------------------------

export GPG_TTY=$TTY

if [[ -d '/usr/local/MacGPG2/bin' ]]; then
  path+='/usr/local/MacGPG2/bin'
fi

if (( ! $+commands[gpg-agent] )); then
  return 1
fi

gpg-refresh-agent() {
  gpg-connect-agent updatestartuptty /bye >/dev/null
}

gpgconf --launch gpg-agent

# Set SSH to use gpg-agent if it is configured to do so
if [[ "$(<~/.gnupg/gpg-agent.conf)" = *enable-ssh-support* ]]; then
  unset SSH_AGENT_PID
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# Disable GUI prompts inside SSH.
if [[ -n "$SSH_CONNECTION" ]]; then
  export PINENTRY_USER_DATA='USE_CURSES=1'
fi
