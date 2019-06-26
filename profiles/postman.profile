export POSTMAN_LOG_DIR=$JG_MADE_SYSTEM/logs/postman;
export POSTMAN_SCREEN_NAME=postman;
function postman() {
    /opt/Postman/Postman
}
alias postman=postman

function postman_screen() {
    if (screen -ls | grep -q $POSTMAN_SCREEN_NAME)
    then
        echo "postman already running...";
    else
        echo "starting postman...";
        screen -S $POSTMAN_SCREEN_NAME -d -m /opt/Postman/Postman >> $POSTMAN_LOG_DIR/output.log 2>>$POSTMAN_LOG_DIR/error.log
    fi
}
alias postman_screen=postman_screen

function postman_kill() {
    if (screen -ls | grep -q $POSTMAN_SCREEN_NAME)
    then
        screen -S $POSTMAN_SCREEN_NAME -X quit
        echo "postman killed";
    fi
}
alias postman_kill=postman_kill
