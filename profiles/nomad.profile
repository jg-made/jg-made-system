# nomad read/write/list

function export_nomad_addr() {
    export NOMAD_ADDR=http://nomad.service.$MADE_ENV.consul:4646;
}

export_nomad_addr

function hyu_nomad1() {
    mock-job-status-response | \
        sed -n -e '/Allocations/,/^$/p' | \
        grep -o -e '^.*running.*$' | \
        awk '{print $2}' | \
        xargs -n 1 nomad node status
}

function hyu_nomad2() {
    mock-node-status | \
        grep -o -E 'Name\s+=\s+.*$' | \
        grep -o -E '[0-9]+[-0-9]*[0-9]+$' | \
        sed 's/-/./g'
}

function get-ip-addresses-of-job() {
    nomad job status $1 | \
        sed -n -e '/Allocations/,/^$/p' | \
        grep -o -e '^.*running.*$' | \
        awk '{print $2}' | \
        xargs -P 1 -I nodeid sh -c '{
nomad node status nodeid | \
grep -o -E 'Name\s+=\s+.*$' | \
grep -o -E '[0-9]+[-0-9]*[0-9]+$' | \
sed 's/-/./g';
}'
}
