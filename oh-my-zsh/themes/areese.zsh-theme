# Needs Git plugin for current_branch method

# Color shortcuts
RED=$fg[red]
YELLOW=$fg[yellow]
GREEN=$fg[green]
WHITE=$fg[white]
BLUE=$fg[blue]
CYAN=$fg[cyan]
RED_BOLD=$fg_bold[red]
YELLOW_BOLD=$fg_bold[yellow]
GREEN_BOLD=$fg_bold[green]
WHITE_BOLD=$fg_bold[white]
BLUE_BOLD=$fg_bold[blue]
RESET_COLOR=$reset_color

# Format for git_prompt_info()
ZSH_THEME_GIT_PROMPT_PREFIX="%{$WHITE%}on %{$BLUE%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# Format for parse_git_dirty()
ZSH_THEME_GIT_PROMPT_DIRTY=" [!]"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Format for git_prompt_status()
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$RED%}unmerged"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$RED%}D"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$YELLOW%}renamed"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$YELLOW%}M"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$GREEN%}A"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{$WHITE%}??"

# Format for git_prompt_ahead()
ZSH_THEME_GIT_PROMPT_AHEAD=" %{$RED%}(!)"

# Format for git_prompt_long_sha() and git_prompt_short_sha()
ZSH_THEME_GIT_PROMPT_SHA_BEFORE=" %{$WHITE%}[%{$RESET_COLOR%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$WHITE%}]"

# Prompt format
PROMPT='
[%{$GREEN%}%~%u%{$RESET_COLOR%}] $(git_prompt_info)$(git_prompt_ahead)
%{$WHITE%}%% %{$RESET_COLOR%}'
#RPROMPT='$(git_prompt_short_sha)$(git_prompt_status)%{$RESET_COLOR%} $(ruby_prompt_info)'
