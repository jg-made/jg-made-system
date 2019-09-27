function good_morning(){
    # get git keychain first
    papiworkon; gfa; cd ~;
    ripworkon; gfa; cd ~;

    # apt things
    sudo apt update -y;
    sudo apt upgrade -y;

    # update asdf things
    asdf plugin-update --all;

    # update spacemacs
    cd ~/.emacs.d; gco develop; gfa; gl; gco jg-made; grb develop; cd ~;

    # open screen
    screen -c $JG_MADE_SYSTEM/screenrcs/lazyfingers.screenrc
}

function madeenv() {
    # this is not ideal cos the consul, vault and nomad env vars are still not set in other shells/windows
    madeenv_core $1;
    export_consul_addr;
    export_vault_addr;
    export_nomad_addr
}
alias madeenv=madeenv;
