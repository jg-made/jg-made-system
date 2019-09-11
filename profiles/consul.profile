# install consul using go + make dev

function export_consul_addr() {
    export CONSUL_HTTP_ADDR=http://consul.service.$MADE_ENV.consul:8500
}
alias export_consul_addr=export_consul_addr

export_consul_addr
