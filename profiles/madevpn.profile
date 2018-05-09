export MADE_VPN_DIR=$JG_MADE_SYSTEM/auths/vpn;

madevpn_secretkey() {
    $MADE_VPN_DIR/secret_key_vpn;
}
alias madevpn_secretkey=madevpn_secretkey;

madevpn_rundaemon() {
    $MADE_VPN_DIR/run_vpn_daemon;
}
alias madevpn_rundaemon=madevpn_rundaemon;
