# install consul using go + make dev

function consul_test() {
    CONSUL_HTTP_ADDR=http://consul.service.test.consul:8500 consul $@
}
alias consul_test=consul_test

function consul_prod() {
    CONSUL_HTTP_ADDR=http://consul.service.prod.consul:8500 consul $@
}
alias consul_prod=consul_prod

function consul_uat() {
    CONSUL_HTTP_ADDR=http://consul.service.uat.consul:8500 consul $@
}
alias consul_uat=consul_uat
