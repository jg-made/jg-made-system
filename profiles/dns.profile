function dns() {
    dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
}
