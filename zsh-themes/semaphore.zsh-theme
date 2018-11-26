# Largely copied from the CRUNCH theme
# Put this in ~/.oh-my-zsh/custom/themes dir

NEWLINE=$'\n'

# Colors
SEMAPHORE_DEFAULT_COLOR="%{$fg[white]%}"
SEMAPHORE_RVM_COLOR="%{$fg[magenta]%}"
SEMAPHORE_DIR_COLOR="%{$fg[cyan]%}"
SEMAPHORE_GIT_BRANCH_COLOR="%{$fg[green]%}"
SEMAPHORE_GIT_CLEAN_COLOR="%{$fg[green]%}"
SEMAPHORE_GIT_DIRTY_COLOR="%{$fg[red]%}"
SEMAPHORE_TIME_COLOR="%{$fg[magenta]%}"
SEMAPHORE_PRP_COLOR="%{$fg[magenta]%}"

# These Git variables are used by the oh-my-zsh git_prompt_info helper:
ZSH_THEME_GIT_PROMPT_PREFIX="$SEMAPHORE_DEFAULT_COLOR:$SEMAPHORE_GIT_BRANCH_COLOR"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $SEMAPHORE_GIT_CLEAN_COLOR✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" $SEMAPHORE_GIT_DIRTY_COLOR✗"

# Our elements:
if [ -e ~/.rvm/bin/rvm-prompt ]; then
  SEMAPHORE_RVM_="$SEMAPHORE_DEFAULT_COLOR"["$SEMAPHORE_RVM_COLOR\${\$(~/.rvm/bin/rvm-prompt i v g)#ruby-}$SEMAPHORE_DEFAULT_COLOR"]"%{$reset_color%}"
else
  if which rbenv &> /dev/null; then
    SEMAPHORE_RVM_="$SEMAPHORE_DEFAULT_COLOR"["$SEMAPHORE_RVM_COLOR\${\$(rbenv version | sed -e 's/ (set.*$//' -e 's/^ruby-//')}$SEMAPHORE_DEFAULT_COLOR"]"%{$reset_color%}"
  fi
fi
SEMAPHORE_DIR_="$SEMAPHORE_DIR_COLOR%~\$(git_prompt_info)"
SEMAPHORE_PROMPT="${NEWLINE}$SEMAPHORE_PRP_COLOR➭$SEMAPHORE_DEFAULT_COLOR   "

TIME="%D{%L:%M:%S}"
MADE_SYMBOL=$'\xe2\x84\xb3'


# Put it all together!
# PROMPT="$WIP_PROMPT$SEMAPHORE_RVM_$SEMAPHORE_DIR_$SEMAPHORE_PROMPT%{$reset_color%}"
# PROMPT="$SEMAPHORE_RVM_$SEMAPHORE_DIR_$SEMAPHORE_PROMPT%{$reset_color%}"
# CURRBRANCH="$ZSH_THEME_GIT_PROMPT_PREFIX $(git_current_branch) $ZSH_THEME_GIT_PROMPT_SUFFIX"
PROMPT="$SEMAPHORE_DIR_$SEMAPHORE_PROMPT"

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(git_current_branch)
  if [ -n "$cb" ]; then
    echo "%{$fg_bold[yellow]%}$(work_in_progress)%{$reset_color%}"
  fi
}

# Combine it all into a final right-side prompt
RPS1='$(git_custom_status) $MADE_SYMBOL $EPS1 $SEMAPHORE_TIME_COLOR|$TIME|$SEMAPHORE_DEFAULT_COLOR'
