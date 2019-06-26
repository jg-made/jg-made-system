# Export some useful vars
export RIP_PROJECT_DIR=$HOME/madedotcom/rip;

# LAZY FINGERS
function ripworkon() {
    cd $RIP_PROJECT_DIR
}
alias ripworkon=ripworkon

# KILL RIP CONTAINERS
function ripkill() {
    read -k 1 "confirmkill?kill all RIP containers\? [Y/y to confirm, any other key to decline]"
    echo ""
    case $confirmkill in
    [Yy]* )
        docker container kill $(docker ps -q -f "name=rip.*") 1>/dev/null
        ;;
    * ) ;;
    esac
}
alias ripkill=ripkill

# PRUNE RIP CONTAINERS
function ripprune() {
    read -k 1 "confirmprune?prune all rip containers\? [Y/y to confirm, any other key to decline]"
    echo ""
    case $confirmprune in
    [Yy]* )
        docker container rm -f $(docker ps -a -q -f "name=rip.*")
        ;;
    * ) ;;
    esac
}
alias ripprune=ripprune

function ripdb_local(){
    pgcli postgres://rip:rip@0.0.0.0:5432/rip
}

function ripdb_test(){
    vtest 1>/dev/null
    PGPASSWORD=$(vault read secret/services/rip/db | grep -o -e '^password.*$' | grep -o -e '[^ ]*$') pgcli -h $(consul_test kv get service/rip/db/host) -U rip
}
alias ripdb_test=ripdb_test

function ripdb_uat(){
    vuat 1>/dev/null
    PGPASSWORD=$(vault read secret/services/rip/db | grep -o -e '^password.*$' | grep -o -e '[^ ]*$') pgcli -h $(consul_uat kv get service/rip/db/host) -U rip
}
alias ripdb_uat=ripdb_uat

function ripdb_prod(){
    vprod 1>/dev/null
    PGPASSWORD=$(vault read secret/services/rip/db | grep -o -e '^password.*$' | grep -o -e '[^ ]*$') pgcli -h $(consul_prod kv get service/rip/db/host) -U rip
}
alias ripdb_test=ripdb_test

function ripvizpdf_test(){
    vtest 1>/dev/null
    PGPASSWORD=$(vault read secret/services/rip/db | grep -o -e '^password.*$' | grep -o -e '[^ ]*$') eralchemy -i "postgresql+psycopg2://rip@$(consul_test kv get service/rip/db/host)" -o ~/Desktop/ripvizpdf_$(date +%F_%T).pdf
}

function ripvizpdf_prod(){
    vprod 1>/dev/null
    PGPASSWORD=$(vault read secret/services/rip/db | grep -o -e '^password.*$' | grep -o -e '[^ ]*$') eralchemy -i "postgresql+psycopg2://rip@$(consul_prod kv get service/rip/db/host)" -o ~/Desktop/ripvizpdf_$(date +%F_%T).pdf
}
