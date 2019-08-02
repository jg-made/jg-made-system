MADE_ENV_PATH=$HOME/.made_env

function madeenv() {
    # this function actually _sets_ $MADE_ENV using the $MADE_ENV_PATH file
    if [ -n "$1" ]
    then
        echo "setting MADE environment to \`$1:u\`"
        echo $1:l > $MADE_ENV_PATH;
        export MADE_ENV=$(cat $MADE_ENV_PATH 2>/dev/null);
    else
        export MADE_ENV=$(cat $MADE_ENV_PATH 2>/dev/null);
        if [ -n "$MADE_ENV" ]
        then
            :
            #I have this info in my semaphore zsh theme so don't need it here.
            # echo "currently using MADE environment $MADE_ENV:u"
        else
            echo "WARNING! MADE_ENV is not set."
            madeenv test
        fi
    fi
}
alias madeenv=madeenv;

madeenv;
