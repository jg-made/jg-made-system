# nomad read/write/list

function export_nomad_addr() {
    export NOMAD_ADDR=http://nomad.service.$MADE_ENV.consul:4646;
}

export_nomad_addr

function get-ip-addresses-of-job() {
    nomad job status $1 | \
        sed -n -e '/Allocations/,/^$/p' | \
        grep -o -e '^.*running.*$' | \
        awk '{print $2}' | \
        xargs -n 1 nomad node status | \
        grep -o -E 'Name\s+=\s+.*$' | \
        grep -o -E '[0-9]+[-0-9]*[0-9]+$' | \
        sed 's/-/./g'
}
