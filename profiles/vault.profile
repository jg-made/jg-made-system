# vault read/write/list

function vault_login_env() {
    export VAULT_ADDR=http://active.vault.service.$1.consul:8200 
    token=`sudo cat $JG_MADE_SYSTEM/auths/vault/github_token`
    vault login -method=github token=$token
}
alias vault_login_env=vault_login_env

function vtest() {
    vault_login_env test
}
alias vtest=vtest

function vuat() {
    vault_login_env uat
}
alias vuat=vuat

function vprod() {
    vault_login_env prod
}
alias vprod=vprod

function vault_password() {
    vault read $1 | grep -o -e '^password.*$' | grep -o -e '[^ ]*$'
}
alias vault_password=vault_password

function vault_secret_salt() {
    vault read $1 | grep -o -e '^secret_salt.*$' | grep -o -e '[^ ]*$'
}
alias vault_secret_salt=vault_secret_salt

function vault_token() {
    vault read $1 | grep -o -e '^token.*$' | grep -o -e '[^ ]*$'
}
alias vault_token=vault_token

# TODO @jg-made consolidate these pwd/token/salt fxns
