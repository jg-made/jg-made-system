# Export some useful vars
export PROCUREMENT_PROJECT_DIR=$HOME/madedotcom/procurement;

# LAZY FINGERS
function papiworkon() {
    cd $PROCUREMENT_PROJECT_DIR
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

function papidb_local(){
    pgcli postgres://procurement:procurement@0.0.0.0:5432/procurement
}

function papidb_test(){
    vtest 1>/dev/null
    PGPASSWORD=$(vault_password secret/services/procurement/db) pgcli -h $(consul_env test kv get service/procurement/db/host) -U procurement
}
alias papidb_test=papidb_test

function papidb_uat(){
    vuat 1>/dev/null
    PGPASSWORD=$(vault_password secret/services/procurement/db) pgcli -h $(consul_env uat kv get service/procurement/db/host) -U procurement
}
alias papidb_uat=papidb_uat

function papidb_prod(){
    vprod 1>/dev/null
    PGPASSWORD=$(vault_password secret/services/procurement/db) pgcli -h $(consul_env prod kv get service/procurement/db/host) -U procurement
}
alias papidb_test=papidb_test

function papivizpdf_test(){
    vtest 1>/dev/null
    PGPASSWORD=$(vault_password secret/services/procurement/db) eralchemy -i "postgresql+psycopg2://procurement@$(consul_env test kv get service/procurement/db/host)" -o ~/Desktop/papivizpdf_$(date +%F_%T).pdf
}

function papivizpdf_prod(){
    vprod 1>/dev/null
    PGPASSWORD=$(vault_password secret/services/procurement/db) eralchemy -i "postgresql+psycopg2://procurement@$(consul_env prod kv get service/procurement/db/host)" -o ~/Desktop/papivizpdf_$(date +%F_%T).pdf
}
