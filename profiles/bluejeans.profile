export BLUEJEANS_LOG_DIR=$JG_MADE_SYSTEM/logs/bluejeans;
bluejeans() {
  if (screen -ls | grep -q bluejeans)
  then 
    echo "bluejeans already running...";
  else
    echo "starting bluejeans...";
    screen -S bluejeans -d -m /opt/bluejeans/bluejeans-bin > $BLUEJEANS_LOG_DIR/output.log 2>$BLUEJEANS_LOG_DIR/error.log
  fi
}
alias bluejeans=bluejeans

bluejeans_kill() {
  if (screen -ls | grep -q bluejeans)
  then 
    screen -S bluejeans -X quit
    echo "bluejeans killed";
  fi
}
alias bluejeans_kill=bluejeans_kill
