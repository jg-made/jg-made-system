function good_morning() {
    cd $HOME/.emacs.d && gco develop && gfa && gl && gco jg-made && git rebase develop && cd $HOME
    cd $HOME
    madevpn_kill
    madevpn_start
    sudo apt update
    sudo apt upgrade -y
    cd $PROCUREMENT_PROJECT_DIR
    emw $PROCUREMENT_PROJECT_DIR
    bluejeans
}
