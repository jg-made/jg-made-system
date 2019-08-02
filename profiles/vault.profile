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
    echo "NB!!! make sure you ran \`vault_login\`"
}
alias advise_vault_login=advise_vault_login

export_vault_addr
