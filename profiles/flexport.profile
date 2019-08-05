function flexport_env() {
    vault_check_token || return 1;
    DB_HOST=$(consul_env $MADE_ENV kv get service/procurement/db/host);
    DB_PASSWORD=$(vault_grep password secret/services/procurement/db);
    FLEXPORT_TOKEN=$(vault_grep token secret/services/procurement/flexport);
    FLEXPORT_API_URL='https://api.flexport.com/';
    echo DB_HOST: $DB_HOST;
    echo DB_PASSWORD: $DB_PASSWORD;
    echo FLEXPORT_TOKEN: $FLEXPORT_TOKEN;
    echo FLEXPORT_API_URL: $FLEXPORT_API_URL;
    DB_HOST=$DB_HOST DB_PASSWORD=$DB_PASSWORD FLEXPORT_API_URL=$FLEXPORT_API_URL FLEXPORT_TOKEN=$FLEXPORT_TOKEN $@;
}
alias flexport_env=flexport_env;
