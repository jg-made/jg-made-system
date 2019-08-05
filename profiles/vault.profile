# vault read/write/list

function export_vault_addr() {
    export VAULT_ADDR=http://active.vault.service.$MADE_ENV.consul:8200;
}

function vault_login() {
    export_vault_addr;
    token=`sudo cat $JG_MADE_SYSTEM/auths/vault/github_token`;
    vault login -method=github token=$token;
}
alias vault_login=vault_login

function vault_grep() {
    export_vault_addr;
    vault read $2 | grep -o -e "^$1.*$" | grep -o -e '[^ ]*$'
}
alias vault_grep=vault_grep

function vault_check_token() {
    madeenv; # do this to ensure made env env var is set correctly in current shell.
    if (vault status > /dev/null 2> /dev/null) && [ $VAULT_ADDR == http://active.vault.service.$MADE_ENV.consul:8200 ]
    then
        return 0
    fi
    echo "You are not logged in to Vault $MADE_ENV environment. Please run \`vault_login\`"
    return 1
}
alias vault_check_token=vault_check_token

export_vault_addr
