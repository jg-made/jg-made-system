# Ensure DB passwords not known globally
source $JG_MADE_SYSTEM/auths/unset/hacienda.profile;

# Export some useful vars
export HACIENDA_SCREEN_NAME=hacienda_dkcub;
export HACIENDA_PROJECT_DIR=$HOME/madedotcom/hacienda;
export HACIENDA_LOGS_DIR=$JG_MADE_SYSTEM/logs/$HACIENDA_SCREEN_NAME;

# Allow later functions to be run from any directory
hrun_in_project_dir() {
    current_dir=$(pwd);
    cd $HACIENDA_PROJECT_DIR;
    "$@";
    cd $current_dir;
}

# SETTING DB PASSWORDS
hdb_with_auth() {
    # Source the DB passwords
    source $JG_MADE_SYSTEM/auths/hacienda/hacienda.profile;
    case $1 in
    "local" | "docker")
        password=$HACIENDA_PGPASSWORD_LOCAL
        ;;
    "test")
        password=$HACIENDA_PGPASSWORD_TEST
        ;;
    *)
        password=''
        ;;
    esac
    shift 1
    PGPASSWORD=$password "$@";
    source $JG_MADE_SYSTEM/auths/unset/hacienda.profile;
}

# DB ACCESS ALIASES
alias hdb_local='hdb_with_auth local pgcli -p 5432 -h 127.0.0.1 -U hacienda hacienda';
alias hdb_docker='hdb_with_auth docker hrun_in_project_dir docker-compose exec hacienda psql --username=hacienda --host=db';
alias hdb_test='hdb_with_auth test pgcli -U hacienda -h test-hacienda.c6vg0z0aw3eq.eu-west-1.rds.amazonaws.com hacienda';

# STOPPING APP
hkill() {
    if (screen -ls | grep -q $HACIENDA_SCREEN_NAME)
        then
            echo "killing $HACIENDA_SCREEN_NAME, please wait...";
            # send ctrl+c to the container (note the use of exit in hrestart_heavy)
            screen -S $HACIENDA_SCREEN_NAME -X -p 0 stuff $'\003';
            while (screen -ls | grep -q $HACIENDA_SCREEN_NAME)
            do
                sleep 1;
            done
            screen -S $HACIENDA_SCREEN_NAME -X quit;
    fi
}
alias hkill=hkill;

# (RE)STARTING APP THOROUGHLY
hrestart_heavy() {
    echo "restarting $HACIENDA_SCREEN_NAME";
    log_filepath="$HACIENDA_LOGS_DIR/$(date +%F_%T).log";
    dkcub_cmd="docker-compose up --build | tee $log_filepath; exit";
    hkill;
    hdb_with_auth local screen -S $HACIENDA_SCREEN_NAME -d -m bash -c $dkcub_cmd;
    ln -s -f $log_filepath $HACIENDA_LOGS_DIR/latest
}
alias hrestart_heavy='hrun_in_project_dir hrestart_heavy';

# RESTARTING APP QUICKLY
alias hrestart_light='hdb_with_auth local hrun_in_project_dir docker-compose exec hacienda s6-svc -h var/run/s6/services/hacienda';

# RUNNING TESTS ON CONTAINER USING FILES CREATED ON THE CONTAINER
hrun_tests_on_container()  {
    docker-compose exec hacienda sh -c "\
        mkdir -p /test_scripts;
        echo 'run-contexts -s /opt/hacienda/hacienda/tests/$2' > /test_scripts/unit_tests;
        chmod +x /test_scripts/unit_tests;
        echo 'run-contexts -s /opt/hacienda/hacienda/acceptance/$2' > /test_scripts/acceptance_tests;
        chmod +x /test_scripts/acceptance_tests;
        echo 'run-contexts -s /opt/hacienda/hacienda/tests/integration/$2' > /test_scripts/integration_tests;
        chmod +x /test_scripts/integration_tests;
";
    docker-compose exec hacienda sh -i --init-file $1;
}

# RUNNING TESTS LOCALLY
hut_local(){ hrun_in_project_dir run-contexts -s src/hacienda/tests/$1 };
hat_local(){ hrun_in_project_dir run-contexts -s src/hacienda/acceptance/$1 };
hit_local(){ hrun_in_project_dir run-contexts -s src/hacienda/tests/integration/$1 };

# INSTALL IPDB ON CONTAINER
# see https://github.com/madedotcom/hacienda/issues/779
alias hipdb_docker="docker exec --privileged hacienda_app sh -c '\
    apk del postgresql-dev;
    sudo apk add openssl-dev;
    pip uninstall pyopenssl -y;
    pip install -U pyopenssl;
    pip install ipdb;
'";

# RUNNING TESTS ALIASES
alias hut_local=hut_local;
alias hat_local=hat_local;
alias hit_local=hit_local;
alias hut_docker='hrun_in_project_dir hrun_tests_on_container /test_scripts/unit_tests';
alias hat_docker='hrun_in_project_dir hrun_tests_on_container /test_scripts/acceptance_tests';
alias hit_docker='hrun_in_project_dir hrun_tests_on_container /test_scripts/integration_tests';

# QUICK ACCESS LATEST LOG OF LATEST LOCAL RUN
alias hlatestlog='vim $HACIENDA_LOGS_DIR/latest';

# VISUALIZE THE SCHEMA AND RELATIONS
alias hvizpdf="hdb_with_auth test eralchemy -i 'postgresql+psycopg2://hacienda:$PGPASSWORD@test-hacienda.c6vg0z0aw3eq.eu-west-1.rds.amazonaws.com/hacienda' -o ~/Desktop/hvizpdf_$(date +%F_%T).pdf"


# BELOW HERE IS ALL EXPERIMENTAL RUBBISH
#
## INSTALL PYRASITE-SHELL ON CONTAINER
## this only works if you add this to the overrider compose yml for the app service
##     cap_add:
##       - SYS_PTRACE
##     privileged: true
#alias hpyrasite_install="hipdb_docker; docker exec hacienda_app sh -c '\
    #apk add gdb;
    #pip install pyrasite;
    #echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    #ps -ef | grep python;
#'";
#
## AWAKEN THE SLEEPING GIANT
##alias hrestart_giant="hrestart_heavy; sleep 40; hpyrasite_install; echo 'DONE';";
