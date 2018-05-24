# Source the DB passwords
source $JG_MADE_SYSTEM/auths/hacienda/hacienda.profile;

# Export some useful vars
export HACIENDA_PROJECT_DIR=$HOME/madedotcom/hacienda;
export HACIENDA_SCREEN_NAME=hacienda_dkcub;

# Allow later functions to be run from any directory
hrun_in_project_dir() {
    current_dir=$(pwd);
    cd $HACIENDA_PROJECT_DIR;
    "$@";
    cd $current_dir;
}

# STARTING/STOPPING APP
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

hrestart_heavy() {
    hkill;
    echo "restarting $HACIENDA_SCREEN_NAME";
    screen -S $HACIENDA_SCREEN_NAME -d -m bash -c 'docker-compose up --build > $JG_MADE_SYSTEM/logs/$HACIENDA_SCREEN_NAME/$(date +%F_%T).log; exit';
}
alias hrestart_heavy='hrun_in_project_dir hrestart_heavy';

alias hrestart_light='hrun_in_project_dir docker-compose exec hacienda s6-svc -h var/run/s6/services/hacienda';

# RUNNING TESTS
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

alias hut_local='hrun_in_project_dir run-contexts -s src/hacienda/tests/$1';
alias hat_local='hrun_in_project_dir run-contexts -s src/hacienda/acceptance/$1';
alias hit_local='hrun_in_project_dir run-contexts -s src/hacienda/tests/integration/$1';
alias hut_docker='hrun_in_project_dir hrun_tests_on_container /test_scripts/unit_tests';
alias hat_docker='hrun_in_project_dir hrun_tests_on_container /test_scripts/acceptance_tests';
alias hit_docker='hrun_in_project_dir hrun_tests_on_container /test_scripts/integration_tests';

# ACCESSING DB
alias hdb_local='PGPASSWORD=$HACIENDA_DB_PASSWORD pgcli -p 5432 -h 127.0.0.1 -U hacienda hacienda';
alias hdb_docker='PGPASSWORD=$HACIENDA_DB_PASSWORD hrun_in_project_dir docker-compose exec hacienda psql --username=hacienda --host=db';
alias hdb_test='PGPASSWORD=$HACIENDA_PGPASSWORD_TEST pgcli -U hacienda -h test-hacienda.c6vg0z0aw3eq.eu-west-1.rds.amazonaws.com hacienda';
