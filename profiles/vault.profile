export VAULT_ADDR=http://active.vault.service.test.consul:8200 

vtest() {
    token=`sudo cat $JG_MADE_SYSTEM/auths/vault/github_token`
    vault login -method=github token=$token
}
alias vtest=vtest
