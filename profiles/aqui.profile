# Export some useful vars
export AQUI_PROJECT_DIR=$HOME/madedotcom/aqui;

# LAZY FINGERS
function aquiworkon() {
    cd $AQUI_PROJECT_DIR
}
alias aquiworkon=aquiworkon

# KILL AQUI CONTAINERS
function aquikill() {
    read -k 1 "confirmkill?kill all aqui containers\? [Y/y to confirm, any other key to decline]"
    echo ""
    case $confirmkill in
        [Yy]* )
            docker container kill $(docker ps -q -f "name=aqui.*") 1>/dev/null
            ;;
        * ) ;;
    esac
}
alias aquikill=aquikill

# PRUNE AQUI CONTAINERS
function aquiprune() {
    read -k 1 "confirmprune?prune all aqui containers\? [Y/y to confirm, any other key to decline]"
    echo ""
    case $confirmprune in
        [Yy]* )
            docker container rm -f $(docker ps -a -q -f "name=aqui.*")
            ;;
        * ) ;;
    esac
}
alias aquiprune=aquiprune
