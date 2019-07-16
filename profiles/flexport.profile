function flexport_env() {
    DB_HOST=$(consul_test kv get service/procurement/db/host) \
    DB_PASSWORD=$(vault_password secret/services/procurement/db) \
    FLEXPORT_TOKEN=$(vault_token secret/services/procurement/flexport) \
    $@;
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
