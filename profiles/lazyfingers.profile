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
    screen -d -m -S x;

    # give screen a big 5 seconds for shell profiles to load
    sleep 5;

    screen -c $JG_MADE_SYSTEM/screenrcs/lazyfingers.screenrc
    # screen -S x -X stuff 'jira_what_am_i_doing;'$(echo -ne '\015')
    # screen -r;
}

function madeenv() {
    madeenv_core $1;
    export_consul_addr;
    export_vault_addr;
    export_nomad_addr
}
alias madeenv=madeenv;
