# vault read/write/list

vault_login_env() {
    export VAULT_ADDR=http://active.vault.service.$1.consul:8200 
    token=`sudo cat $JG_MADE_SYSTEM/auths/vault/github_token`
    vault login -method=github token=$token
}
alias vault_login_env=vault_login_env

vtest() {
    vault_login_env test
}
alias vtest=vtest

vuat() {
    vault_login_env uat
}
alias vuat=vuat

vprod() {
    vault_login_env prod
}
alias vprod=vprod
