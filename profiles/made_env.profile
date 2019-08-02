MADE_ENV_PATH=$HOME/.made_env

# ensure made_env_path file exists
if [ ! -f "$MADE_ENV_PATH" ]
then
    echo test > $MADE_ENV_PATH;
else
    :
fi

export MADE_ENV=$(cat $MADE_ENV_PATH 2>/dev/null);

function set_and_print_made_env() {
    # this function actually _sets_ $MADE_ENV using the $MADE_ENV_PATH file
    export MADE_ENV=$(cat $MADE_ENV_PATH 2>/dev/null);
    if [ -n "$MADE_ENV" ]
    then
        echo "currently using MADE environment \`$MADE_ENV\`"
    else
        echo "WARNING! MADE_ENV is not set. Please check $MADE_ENV_PATH contents. Should be test, prod or uat."
    fi
}
alias set_and_print_made_env=set_and_print_made_env;
