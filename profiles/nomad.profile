# nomad read/write/list

function export_nomad_addr() {
    export NOMAD_ADDR=http://nomad.service.$MADE_ENV.consul:4646;
}

export_nomad_addr
