# Ensure DB passwords not known globally
source $JG_MADE_SYSTEM/auths/unset/procurement.profile;

# Export some useful vars
export PROCUREMENT_API_PROJECT_DIR=$HOME/madedotcom/procurement;

# LAZY FINGERS
function papiworkon() {
    cd $PROCUREMENT_API_PROJECT_DIR
}
alias papiworkon=papiworkon

# KILL PROCUREMENT CONTAINERS
function papikill() {
    read -k 1 "confirmkill?kill all procurement containers\? [Y/y to confirm, any other key to decline]"
    echo ""
    case $confirmkill in
    [Yy]* )
        docker container kill $(docker ps -q -f "name=procurement.*") 1>/dev/null
        ;;
    * ) ;;
    esac
}
alias papikill=papikill

# PRUNE PROCUREMENT CONTAINERS
function papiprune() {
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

function papidb_test(){
    vtest && vault read secret/services/procurement/db
    pgcli -h $(consul_test kv get service/procurement/db/host) -U procurement
}
alias papidb_test=papidb_test

function papidb_prod(){
    vprod && vault read secret/services/procurement/db
    pgcli -h $(consul_prod kv get service/procurement/db/host) -U procurement
}
alias papidb_test=papidb_test
