# Ensure DB passwords not known globally
source $JG_MADE_SYSTEM/auths/unset/procurement.profile;
    
# Export some useful vars
export PROCUREMENT_API_SCREEN_NAME=papidkcub;
export PROCUREMENT_API_PROJECT_DIR=$HOME/madedotcom/procurement;
export PROCUREMENT_API_LOGS_DIR=$JG_MADE_SYSTEM/logs/$PROCUREMENT_API_SCREEN_NAME;

export PROCUREMENT_UI_SCREEN_NAME=puidkcub;
export PROCUREMENT_UI_PROJECT_DIR=$HOME/madedotcom/procurement-ui;
export PROCUREMENT_UI_LOGS_DIR=$JG_MADE_SYSTEM/logs/$PROCUREMENT_UI_SCREEN_NAME;

# Allow later functions to be run from any directory
papi_run_in_project_dir() {
    current_dir=$(pwd);
    cd $PROCUREMENT_API_PROJECT_DIR;
    "$@";
    cd $current_dir;
}
alias papi_run_in_project_dir=papi_run_in_project_dir

# LAZY FINGERS
papiworkon() {
    cd $PROCUREMENT_API_PROJECT_DIR
}
alias papiworkon=papiworkon

puiworkon() {
    cd $PROCUREMENT_UI_PROJECT_DIR
}
alias puiworkon=puiworkon
  
# KILL PROCUREMENT CONTAINERS 
papikill() { 
    read -k 1 "confirmkill?kill all procurement containers\? [Y/y to confirm, any other key to decline]" 
    echo "" 
    case $confirmkill in 
    [Yy]* ) 
        docker container kill $(docker ps -a -q -f "name=procurement.*") 
        ;; 
    * ) ;; 
    esac 
} 
alias papikill=papikill 

# PRUNE PROCUREMENT CONTAINERS 
papiprune() { 
    read -k 1 "confirmprune?prune all procurement containers\? [Y/y to confirm, any other key to decline]" 
    echo "" 
    case $confirmprune in 
    [Yy]* ) 
        docker container rm -f $(docker ps -a -q -f "name=procurement.*") 
        ;; 
    * ) ;; 
    esac 
} 
alias papiprune=papiprune 

# CREATE LOGS
papimakelogs() {
    nowy=$(date +%F_%T)
    services_str=$(papi_run_in_project_dir docker-compose ps --services)
    services_arr=($(echo "$services_str" | tr ',' '\n'))
    ## now loop through the above array
    for i in "${services_arr[@]}"
    do
        echo "${nowy}_${i}"
        log_filename="$PROCUREMENT_API_LOGS_DIR/${nowy}_${i}.log"
        symlink_filename="$PROCUREMENT_API_LOGS_DIR/latest_$i.log"
        papi_run_in_project_dir docker-compose logs "$i" > $log_filename
        ln -s -f $log_filename $symlink_filename
    done
}
alias papimakelogs=papimakelogs

alias papilatestlog_api='vim $PROCUREMENT_API_LOGS_DIR/latest_api.log'
alias papilatestlog_eventconsumer='vim $PROCUREMENT_API_LOGS_DIR/latest_eventconsumer.log'
alias papilatestlog_acceptance='vim $PROCUREMENT_API_LOGS_DIR/latest_acceptance.log'
