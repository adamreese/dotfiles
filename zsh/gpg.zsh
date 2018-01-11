# zsh gpg
# -----------------------------------------------------------------------------

export GPG_TTY=$(tty)

if (( ! $+commands[gpg-agent] )); then
  return 1
fi

gpgconf --launch gpg-agent

# Set SSH to use gpg-agent if it is configured to do so
if grep -q '^enable-ssh-support' "${GNUPGHOME}/gpg-agent.conf" /dev/null 2>&1; then
  unset SSH_AGENT_PID
  export SSH_AUTH_SOCK="${GNUPGHOME}/S.gpg-agent.ssh"
fi

# -----------------------------------------------------------------------------
# vim:ft=zsh
