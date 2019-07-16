# install consul using go + make dev

function consul_env() {
    consul_env_name=$1
    shift 1
    CONSUL_HTTP_ADDR=http://consul.service.$consul_env_name.consul:8500 consul $@
}
alias consul_env=consul_env
