# Export some useful vars
export PROCUREMENT_PROJECT_DIR=$HOME/madedotcom/procurement;

# LAZY FINGERS
function papiworkon() {
    cd $PROCUREMENT_PROJECT_DIR
}
alias papiworkon=papiworkon

function papiscreen() {
    screen -c $JG_MADE_SYSTEM/screenrcs/papi.screenrc
}
alias papiscreen=papiscreen

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
alias papidb_local=papidb_local

function papidb(){
    vault_check_token || return 1;
    PGPASSWORD=$(vault_grep password secret/services/procurement/db) pgcli -h $(consul_env $MADE_ENV kv get service/procurement/db/host) -U procurement
}
alias papidb=papidb;

function papivizpdf(){
    vault_check_token || return 1;
    PGPASSWORD=$(vault_grep password secret/services/procurement/db) eralchemy -i "postgresql+psycopg2://procurement@$(consul_env $MADE_ENV kv get service/procurement/db/host)" -o ~/Desktop/papivizpdf_$(date +%F_%T).pdf;
}
alias papivizpdf=papivizpdf;

function papipg_dump(){
    vault_check_token || return 1;
    # https://dba.stackexchange.com/questions/55291/copy-postgresql-database-from-a-remote-server
    # you might have to do something like this:
    # createdb "papi_$MADE_ENV" -U procurement
    PGPASSWORD=$(vault_grep password secret/services/procurement/db) pg_dump -h $(consul_env $MADE_ENV kv get service/procurement/db/host) -U procurement | psql -h localhost -d papi -U procurement
    # READ THIS: http://www.postgresqltutorial.com/postgresql-rename-database/
}
alias papipg_dump=papipg_dump;
