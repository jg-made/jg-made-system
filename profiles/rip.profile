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
    docker exec -i -t $(docker ps -q -f "name=rip_postgres.*") psql -U rip
}
alias ripdb_local=ripdb_local;

function ripdb(){
    vault_check_token || return 1;
    PGPASSWORD=$(vault_grep password secret/services/rip/db) pgcli -h $(consul_env $MADE_ENV kv get service/rip/db/host) -U rip;
}
alias ripdb=ripdb;

function ripvizpdf(){
    vault_check_token || return 1;
    PGPASSWORD=$(vault_grep password secret/services/rip/db) eralchemy -i "postgresql+psycopg2://rip@$(consul_env $MADE_ENV kv get service/rip/db/host)" -o ~/Desktop/ripvizpdf_$(date +%F_%T).pdf;
}
alias ripvizpdf=ripvizpdf;

function riptoken(){
    vault_check_token || return 1;
    # TODO @jg-make this work locally too
    (cd $RIP_PROJECT_DIR; HTTP_AUTH_SECRET_SALT=$(vault_grep secret_salt secret/services/rip/http_auth) python scripts/http_auth_token_generator.py $1 2099-12-31T23:59:59);
}
alias rip_token=rip_token;

function rip_manual_migration(){
    vault_check_token || return 1;
    DB_HOST=$(consul_env $MADE_ENV kv get service/rip/db/host) DB_PASSWORD=$(vault_grep password secret/services/rip/db) DB_PORT=5432 ./manual_migration.sh;
}
alias rip_manual_migration=rip_manual_migration

function rip_get_returnable_lines_test(){
    PGPASSWORD=$(vault_grep password secret/services/rip/db) \
              psql -h $(consul_env test kv get service/rip/db/host) -U rip -t -c \
              "select op.order_id, ol.sku, ol.item_id \
from order_placed as op \
join dispatches as di on di.order_id = op.order_id \
join order_lines as ol on ol.order_surrogate_id = op.surrogate_id \
group by op.order_id, ol.sku, ol.item_id\
;" \
        | sed -e 's/|/\n/g' \
        | xargs -n 3 -l sh -c \
                'HTTP_AUTH_SECRET_SALT=$(vault_grep secret_salt secret/services/rip/http_auth) \
./scripts/http_auth_token_generator.py $0 \
--quiet=True \
--autocopy=False \
| xargs -I token \
curl -s 'http://rip.made-test.com/orders/token' \
&& echo { && echo \"order_id\": \"$0\", && echo \"sku\": \"$1\", && echo \"item_id\": \"$2\", && echo }' \
        | grep -e 'returnable\":true' -A 5 \
        | grep -e '^{$' -A 4
}
alias rip_get_returnable_lines_test=rip_get_returnable_lines_test
