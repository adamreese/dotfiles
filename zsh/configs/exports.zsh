# vim: ft=zsh :

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Less
export LESS='-g -i -M -R -S -w -z-4'
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
elif (( $+commands[lesspipe] )); then
  export LESSOPEN='| /usr/bin/env lesspipe %s 2>&-'
fi
