# Ensure DB passwords not known globally
source $JG_MADE_SYSTEM/auths/unset/procurement.profile;
    
# Export some useful vars
export PROCUREMENT_API_SCREEN_NAME=papidkcub;
export PROCUREMENT_API_PROJECT_DIR=$HOME/madedotcom/procurement;
export PROCUREMENT_API_LOGS_DIR=$JG_MADE_SYSTEM/logs/$PROCUREMENT_API_SCREEN_NAME;

export PROCUREMENT_UI_SCREEN_NAME=puidkcub;
export PROCUREMENT_UI_PROJECT_DIR=$HOME/madedotcom/procurement_ui;
export PROCUREMENT_UI_LOGS_DIR=$JG_MADE_SYSTEM/logs/$PROCUREMENT_UI_SCREEN_NAME;

papiworkon() {
    cd $PROCUREMENT_API_PROJECT_DIR
}
alias papiworkon=papiworkon
