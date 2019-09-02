function good_morning(){
    # get git keychain first
    papiworkon; gfa; cd ~;

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

    screen -S x -X stuff 'emw .; jira_what_am_i_doing;'$(echo -ne '\015')
    screen -r;
}
