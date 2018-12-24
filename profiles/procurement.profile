# Export some useful vars
export PROCUREMENT_PROJECT_DIR=$HOME/madedotcom/procurement;
export REQUESTS_CA_BUNDLE=$PROCUREMENT_PROJECT_DIR/fake-elb/selfsigned-ca.crt

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

function papidb_test(){
    vtest 1>/dev/null
    PGPASSWORD=$(vault read secret/services/procurement/db | grep -o -e '^password.*$' | grep -o -e '[^ ]*$') pgcli -h $(consul_test kv get service/procurement/db/host) -U procurement
}
alias papidb_test=papidb_test

function papidb_prod(){
    vprod 1>/dev/null
    PGPASSWORD=$(vault read secret/services/procurement/db | grep -o -e '^password.*$' | grep -o -e '[^ ]*$') pgcli -h $(consul_prod kv get service/procurement/db/host) -U procurement
}
alias papidb_test=papidb_test

function papivizpdf_test(){
    vtest 1>/dev/null
    PGPASSWORD=$(vault read secret/services/procurement/db | grep -o -e '^password.*$' | grep -o -e '[^ ]*$') eralchemy -i "postgresql+psycopg2://procurement@$(consul_test kv get service/procurement/db/host)" -o ~/Desktop/papivizpdf_$(date +%F_%T).pdf
}

function papivizpdf_prod(){
    vprod 1>/dev/null
    PGPASSWORD=$(vault read secret/services/procurement/db | grep -o -e '^password.*$' | grep -o -e '[^ ]*$') eralchemy -i "postgresql+psycopg2://procurement@$(consul_prod kv get service/procurement/db/host)" -o ~/Desktop/papivizpdf_$(date +%F_%T).pdf
}
