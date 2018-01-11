# zsh ssh
# -----------------------------------------------------------------------------

# Aliases
# -----------------------------------------------------------------------------
alias sshtmp='ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'

# Trying out gpg-agent for ssh
return 1

if (( ! $+commands[ssh-agent] )); then
  return 1
fi

if ! ssh-add -l > /dev/null; then
  ssh-add -K 2> /dev/null
fi

# Set the path to the environment file if not set by another module.
_ssh_agent_env="${_ssh_agent_env:-${TMPDIR:-/tmp}/ssh-agent.env}"

# Start ssh-agent if not started.
if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
  # Export environment variables.
  source "$_ssh_agent_env" 2> /dev/null
  eval "$(ssh-agent -s)"
fi

# Load identities.
if ssh-add -l 2>&1 | grep -q 'The agent has no identities'; then
  # In macOS, `ssh-add -A` will load all identities defined in Keychain
  if [[ `uname -s` == 'Darwin' ]]; then
    ssh-add -A 2> /dev/null
  else
    ssh-add 2> /dev/null
  fi
fi

# Clean up.
unset _ssh_agent_env

# -----------------------------------------------------------------------------
# vim:ft=zsh
