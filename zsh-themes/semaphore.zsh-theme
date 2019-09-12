# Based on the CRUNCH theme
# Put this in ~/.oh-my-zsh/custom/themes dir

NEWLINE=$'\n'

# Colors
SEMAPHORE_DEFAULT_COLOR="%{$fg[white]%}"
SEMAPHORE_NVM_COLOR="%{$fg[magenta]%}"
SEMAPHORE_DIR_COLOR="%{$fg[cyan]%}"
SEMAPHORE_GIT_BRANCH_COLOR="%{$fg[green]%}"
SEMAPHORE_GIT_CLEAN_COLOR="%{$fg[green]%}"
SEMAPHORE_GIT_DIRTY_COLOR="%{$fg[red]%}"
SEMAPHORE_TIME_COLOR="%{$fg[yellow]%}"
SEMAPHORE_PRP_COLOR="%{$fg[magenta]%}"

# These Git variables are used by the oh-my-zsh git_prompt_info helper:
ZSH_THEME_GIT_PROMPT_PREFIX="$SEMAPHORE_DEFAULT_COLOR:$SEMAPHORE_GIT_BRANCH_COLOR"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $SEMAPHORE_GIT_CLEAN_COLOR✓$SEMAPHORE_DEFAULT_COLOR"
ZSH_THEME_GIT_PROMPT_DIRTY=" $SEMAPHORE_GIT_DIRTY_COLOR✗$SEMAPHORE_DEFAULT_COLOR"

# fancy looking M to help me orient myself when sshing across the universe
MADE_SYMBOL=$'\xe2\x84\xb3'

# the left hand side prompt
SEMAPHORE_LHS="$SEMAPHORE_DIR_COLOR%~\$(git_prompt_info)"
# newline at the end for ease of reading commands
SEMAPHORE_NEWLINE_PROMPT="${NEWLINE}$SEMAPHORE_PRP_COLOR$MADE_SYMBOL➭$SEMAPHORE_DEFAULT_COLOR "
# final multiline prompt
PROMPT="$SEMAPHORE_LHS$SEMAPHORE_NEWLINE_PROMPT"

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
    local cb=$(git_current_branch)
    if [ -n "$cb" ]; then
        echo "%{$fg_bold[red]%}$(work_in_progress)%{$reset_color%}"
    fi
}

made_env_status() {
    if [ "$MADE_ENV" = "prod" ]; then
        echo "%{$fg_bold[red]%}[env: $MADE_ENV:u]%{$reset_color%}"
    else
        if [ "$MADE_ENV" = "uat" ]; then
            echo "%{$fg_bold[yellow]%}[env: $MADE_ENV:u]%{$reset_color%}"
        else
            echo "%{$fg_bold[magenta]%}[env: $MADE_ENV:u]%{$reset_color%}"
        fi
    fi
}

# 24-hour clock time with seconds
SEMAPHORE_TIME="$SEMAPHORE_TIME_COLOR%D{%K:%M:%S}$SEMAPHORE_DEFAULT_COLOR"

# Put node version (nvm) and time on right hand side prompt
#RPS1='$SEMAPHORE_NVM_COLOR [node-$(nvm_prompt_info)]$SEMAPHORE_DEFAULT_COLOR $(git_custom_status) $SEMAPHORE_TIME'
#RPS1='$(git_custom_status) $SEMAPHORE_TIME'
RPS1='$(made_env_status) $SEMAPHORE_DEFAULT_COLOR $(git_custom_status)'
