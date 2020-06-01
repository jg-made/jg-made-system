# Export some useful vars
export SUP_PROJECT_DIR=$HOME/madedotcom/supplier-hub;

# LAZY FINGERS
function supworkon() {
    cd $SUP_PROJECT_DIR
}
alias supworkon=supworkon

function supdb_local() {
    pgcli postgres://supplier_hub:supplier_hub_password@localhost:5432
}
alias supdb_local=supdb_local
