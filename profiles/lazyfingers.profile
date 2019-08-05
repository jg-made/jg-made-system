function good_morning(){
    # apt things
    sudo apt update -y;
    sudo apt upgrade -y;

    # update asdf things
    asdf plugin-update --all;

    # update spacemacs
    cd ~/.emacs.d; gco develop; gfa; gl; gco jg-made; grb develop; cd ~;

    # open spacemacs
    emw ~;

    # open screen
    # screen -dRR;
    screen -d -m -S good_morning;
    screen -S good_morning -X stuff 'jira_what_am_i_doing'$(echo -ne '\015')
    screen -r;
}
