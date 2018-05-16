source $JG_MADE_SYSTEM/auths/hacienda/hacienda.profile;

export HACIENDA_PROJECT_DIR=$HOME/madedotcom/hacienda;
export HACIENDA_SCREEN_NAME=hacienda_dkcub;

alias hdb='docker-compose exec hacienda psql --username=hacienda --host=db';

hut_docker() {
    docker-compose exec hacienda sh -c "\
mkdir -p /test_scripts;
echo 'run-contexts -s /opt/hacienda/hacienda/tests/$1' > /test_scripts/unit_tests;
chmod +x /test_scripts/unit_tests;
";
    docker-compose exec hacienda sh -i --init-file /test_scripts/unit_tests;
}
alias hut_docker=hut_docker;

hat_docker() {
    docker-compose exec hacienda sh -c "\
mkdir -p /test_scripts;
echo 'run-contexts -s /opt/hacienda/hacienda/acceptance/$1' > /test_scripts/acceptance_tests; chmod +x /test_scripts/acceptance_tests;
";
    docker-compose exec hacienda sh -i --init-file /test_scripts/acceptance_tests;
}
alias hat_docker=hat_docker;

hit_docker() {
    docker-compose exec hacienda sh -c "\
mkdir -p /test_scripts;
echo 'run-contexts -s /opt/hacienda/hacienda/tests/integration/$1' > /test_scripts/integration_tests; chmod +x /test_scripts/integration_tests;
";
    docker-compose exec hacienda sh -i --init-file /test_scripts/integration_tests;
}
alias hit_docker=hit_docker;

hut_local() {
    current_dir=$(pwd);
    cd $HACIENDA_PROJECT_DIR;
    run-contexts -s src/hacienda/tests/$1
    cd $current_dir;
}
alias hut_local=hut_local

hat_local() {
    current_dir=$(pwd);
    cd $HACIENDA_PROJECT_DIR;
    run-contexts -s src/hacienda/acceptance/$1
    cd $current_dir;
}
alias hat_local=hat_local

hit_local() {
    current_dir=$(pwd);
    cd $HACIENDA_PROJECT_DIR;
    run-contexts -s src/hacienda/tests/integration/$1
    cd $current_dir;
}
alias hit_local=hit_local

hkill() {
    if (screen -ls | grep -q $HACIENDA_SCREEN_NAME)
        then
            echo "quitting old $HACIENDA_SCREEN_NAME";
    screen -S $HACIENDA_SCREEN_NAME -X -p 0 stuff $'\003';
    while (screen -ls | grep -q $HACIENDA_SCREEN_NAME)
        do
            sleep 5;
    echo "still quitting old $HACIENDA_SCREEN_NAME";
    done
    screen -S $HACIENDA_SCREEN_NAME -X quit;
    fi
}
alias hkill=hkill;

hrestart() {
    current_dir=$(pwd);
    cd $HACIENDA_PROJECT_DIR;
    hkill;
    echo "starting new $HACIENDA_SCREEN_NAME";
    screen -S $HACIENDA_SCREEN_NAME -d -m bash -c 'docker-compose up --build; exit';
    cd $current_dir;
}
alias hrestart=hrestart;

hdb_test() {
    PGPASSWORD=$HACIENDA_PGPASSWORD_TEST psql -U hacienda -h test-hacienda.c6vg0z0aw3eq.eu-west-1.rds.amazonaws.com hacienda
}
alias hdb_test=hdb_test;
