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

function advise_vault_login() {
    if [ $VAULT_ADDR != http://active.vault.service.$MADE_ENV.consul:8200 ]
    then
        # the vault url is not right. we might be logged in but to the wrong env.
        echo "You are not logged in to Vault $MADE_ENV environment. Please run \`vault_login\`"
    else
        # we don't know if we are logged in to vault. Maybe use `vault status` to script that check?
        echo "NB!!! make sure you ran \`vault_login\`"
    fi
}
alias advise_vault_login=advise_vault_login

export_vault_addr
