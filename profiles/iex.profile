export ERL_AFLAGS="-kernel shell_history enabled"

alias mto='mix test --only $@'

function parse_mix_hex_search_line() {
    local line="$1";
    local arr=("${(s/ /)line}")
    echo "{:${arr[1]}, \"~> ${arr[$((#arr[@] - 2))]}\"},"
}

function mix_hex_search_formatted_output() {
    mix hex.search $1 | grep $1  | while read line; do
        parse_mix_hex_search_line $line
    done
}
