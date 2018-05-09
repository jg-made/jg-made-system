export ZPLUG_HOME=$HOME/.zplug
source $ZPLUG_HOME/init.zsh

# THis used to be OK but is now causing problem.
# Now I just ran once zplug "akarzim/zsh-docker-aliases" to install.
zplug "akarzim/zsh-docker-aliases", use: zshrc

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
