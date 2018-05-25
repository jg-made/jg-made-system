# Ensure DB passwords not known globally
source $JG_MADE_SYSTEM/auths/unset/hacienda.profile;

# Export some useful vars
export HACIENDA_PROJECT_DIR=$HOME/madedotcom/hacienda;
export HACIENDA_SCREEN_NAME=hacienda_dkcub;

# Allow later functions to be run from any directory
hrun_in_project_dir() {
    current_dir=$(pwd);
    cd $HACIENDA_PROJECT_DIR;
    echo "$@";
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
    hkill;
    echo "restarting $HACIENDA_SCREEN_NAME";
    hdb_with_auth local screen -S $HACIENDA_SCREEN_NAME -d -m bash -c 'docker-compose up --build > $JG_MADE_SYSTEM/logs/$HACIENDA_SCREEN_NAME/$(date +%F_%T).log; exit';
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

# RUNNING TESTS ALIASES
alias hut_local=hut_local;
alias hat_local=hat_local;
alias hit_local=hit_local;
alias hut_docker='hrun_in_project_dir hrun_tests_on_container /test_scripts/unit_tests';
alias hat_docker='hrun_in_project_dir hrun_tests_on_container /test_scripts/acceptance_tests';
alias hit_docker='hrun_in_project_dir hrun_tests_on_container /test_scripts/integration_tests';

