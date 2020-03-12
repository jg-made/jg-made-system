function update_spacemacs_fork_to_latest_develop(){
    cd ~/.emacs.d;
    git checkout develop;
    git fetch --all;
    git rebase upstream/develop;
    git checkout jg-made;
    git rebase develop;
    cd ~;
}

function update_everything(){
    # get sudo rights first
    sudo echo " "

    # get git keychain second
    papiworkon; git fetch --all; cd ~;
    ripworkon; git fetch --all; cd ~;

    # apt things
    sudo apt update -y;
    sudo apt upgrade -y;

    # update asdf things
    asdf update;
    asdf plugin-update --all;

    update_spacemacs_fork_to_latest_develop;
}

function good_morning(){
    update_everything
    vpn_like_a_boss;
    screen -dRR;
}

function good_morning_full(){
    update_everything
    vpn_like_a_boss;
    screen -c $JG_MADE_SYSTEM/screenrcs/good_morning_full.screenrc
}

function madeenv() {
    # this is not ideal cos the consul, vault and nomad env vars are still not set in pre-existing shells/windows
    echo "THIS FUNCTION IS DANGEROUS - env vars are only being changed in THIS shell and FUTURE shells"
    madeenv_core $1;
    export_consul_addr;
    export_vault_addr;
    export_nomad_addr
}
alias madeenv=madeenv;


alias o=xdg-open
