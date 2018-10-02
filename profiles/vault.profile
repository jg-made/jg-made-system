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
