export BLUEJEANS_LOG_DIR=$JG_MADE_SYSTEM/logs/bluejeans;
export BLUEJEANS_SCREEN_NAME=bluejeans;

function bluejeans() {
    /opt/bluejeans/bluejeans-bin
}
alias bluejeans=bluejeans

function bluejeans_OLD() {
  if (screen -ls | grep -q $BLUEJEANS_SCREEN_NAME)
  then
    echo "bluejeans already running...";
  else
    echo "starting bluejeans...";
    screen -S $BLUEJEANS_SCREEN_NAME -d -m /opt/bluejeans/bluejeans-bin >> $BLUEJEANS_LOG_DIR/output.log 2>>$BLUEJEANS_LOG_DIR/error.log
  fi
}
alias bluejeans=bluejeans

function bluejeans_kill() {
  if (screen -ls | grep -q $BLUEJEANS_SCREEN_NAME)
  then
    screen -S $BLUEJEANS_SCREEN_NAME -X quit
    echo "bluejeans killed";
  fi
}
alias bluejeans_kill=bluejeans_kill
