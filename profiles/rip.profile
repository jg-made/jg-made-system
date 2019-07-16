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
    PGPASSWORD=$(vault_password secret/services/rip/db) pgcli -h $(consul_test kv get service/rip/db/host) -U rip
}
alias ripdb_test=ripdb_test

function ripdb_uat(){
    vuat 1>/dev/null
    PGPASSWORD=$(vault_password secret/services/rip/db) pgcli -h $(consul_uat kv get service/rip/db/host) -U rip
}
alias ripdb_uat=ripdb_uat

function ripdb_prod(){
    vprod 1>/dev/null
    PGPASSWORD=$(vault_password secret/services/rip/db) pgcli -h $(consul_prod kv get service/rip/db/host) -U rip
}
alias ripdb_test=ripdb_test

function ripvizpdf_test(){
    vtest 1>/dev/null
    PGPASSWORD=$(vault_password secret/services/rip/db) eralchemy -i "postgresql+psycopg2://rip@$(consul_test kv get service/rip/db/host)" -o ~/Desktop/ripvizpdf_$(date +%F_%T).pdf
}

function ripvizpdf_prod(){
    vprod 1>/dev/null
    PGPASSWORD=$(vault_password secret/services/rip/db) eralchemy -i "postgresql+psycopg2://rip@$(consul_prod kv get service/rip/db/host)" -o ~/Desktop/ripvizpdf_$(date +%F_%T).pdf
}

function riptoken_test(){
    vtest 1>/dev/null
    (cd $RIP_PROJECT_DIR; HTTP_AUTH_SECRET_SALT=$(vault_secret_salt secret/services/rip/http_auth) python scripts/http_auth_token_generator.py $1 2099-12-31T23:59:59)
}


function riptoken_prod(){
    vprod 1>/dev/null
    (cd $RIP_PROJECT_DIR; HTTP_AUTH_SECRET_SALT=$(vault_secret_salt secret/services/rip/http_auth) python scripts/http_auth_token_generator.py $1 2099-12-31T23:59:59)
}

function rip_manual_migration_test(){
    vtest 1>/dev/null
    DB_HOST=$(consul_test kv get service/rip/db/host) DB_PASSWORD=$(vault_password secret/services/rip/db) DB_PORT=5432 ./manual_migration.sh
}
