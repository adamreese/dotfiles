# zsh aliases
# -----------------------------------------------------------------------------

# masOS specific command aliases
[[ "${OSTYPE}" == linux* ]] || return

alias     stop='sudo systemctl stop'
alias    start='sudo systemctl start'
alias   reboot='sudo systemctl reboot'
alias   reload='sudo systemctl reload'
alias   status='sudo systemctl status'
alias  restart='sudo systemctl restart'
alias poweroff='sudo systemctl poweroff'

if (( ${+commands[yaourt]} )); then
  alias archup='sudo pacman -Syu && yaourt -Syua --noconfirm'
fi

if (( ${+commands[journalctl]} )); then
  alias jj='journalctl'
fi

# -----------------------------------------------------------------------------
# vim:ft=zsh
