function good_morning(){
    #apt things
    sudo apt update -y;
    sudo apt upgrade -y;

    #update asdf things
    asdf plugin-update --all;

    #update spacemacs
    cd ~/.emacs.d; gco develop; gfa; gl; gco jg-made; grb develop; cd ~;

    #open spacemacs
    emw ~;

    #open sreen
    screen -dRR;
}
