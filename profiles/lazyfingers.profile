alias o=xdg-open
alias b=chromium-browser
alias s="screen -dRR"

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
    supworkon; git fetch --all; cd ~;

    # apt things
    sudo apt update -y;
    sudo apt upgrade -y;

    # git-pulled libs/tools
    cd ~/.pyenv && gfa && gl;
    cd ~/.pyenv/plugins/pyenv-virtualenv && gfa && gl;
    cd ~/.asdf && gfa && gl;
    cd ~/.oh-my-zsh && gfa && gl;

    # update asdf things
    asdf update --head;
    asdf plugin-update --all;

    update_spacemacs_fork_to_latest_develop;
}

function ping_github_to_ensure_internet(){
    ping -c 1 -w 2 -W 2 github.com;
    if [ $? -eq 0 ];
    then
        return 0;
    else
        return 1;
    fi
}

function good_morning(){
    ping_github_to_ensure_internet;
    if [ $? -eq 0 ];
    then
        update_everything;
        emw ~;
        return 0;
    else
        echo "NO INTERNET :("
        return 1;
    fi
}

function good_morning_full(){
    good_morning;
    if [ $? -eq 0 ];
    then
       screen -c $JG_MADE_SYSTEM/screenrcs/good_morning_full.screenrc
    fi
}

function good_morning_full_vpn(){
    good_morning;
    if [ $? -eq 0 ];
    then
       vpn_like_a_boss;
       screen -c $JG_MADE_SYSTEM/screenrcs/good_morning_full.screenrc
    fi
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


