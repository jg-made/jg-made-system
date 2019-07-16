function flexport_env() {
    sleep 5
    DB_HOST=$(consul_test kv get service/procurement/db/host)
    sleep 5
    DB_PASSWORD=$(vault_password secret/services/procurement/db)
    sleep 5
    FLEXPORT_TOKEN=$(vault_token secret/services/procurement/flexport)
    sleep 5
    FLEXPORT_API_URL='https://api.flexport.com/'
    echo DB_HOST: $DB_HOST
    echo DB_PASSWORD: $DB_PASSWORD
    echo FLEXPORT_TOKEN: $FLEXPORT_TOKEN
    echo FLEXPORT_API_URL: $FLEXPORT_API_URL
    DB_HOST=$DB_HOST DB_PASSWORD=$DB_PASSWORD FLEXPORT_API_URL=$FLEXPORT_API_URL FLEXPORT_TOKEN=$FLEXPORT_TOKEN $@;
}

function flexport_env_test(){
    vtest;
    flexport_env $@;
}
function flexport_env_uat(){
    vuat;
    flexport_env $@;
}
function flexport_env_prod(){
    vprod;
    flexport_env $@;
}
