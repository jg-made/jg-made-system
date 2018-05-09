source $JG_MADE_SYSTEM/auths/hacienda/hacienda.profile;
export HACIENDA_PROJECT_DIR=$HOME/madedotcom/hacienda;

alias hdb='docker-compose exec hacienda psql --username=hacienda --host=db';

hut() {
    docker-compose exec hacienda sh -c "\
mkdir -p /test_scripts;
echo 'run-contexts -s /opt/hacienda/hacienda/tests/$1' > /test_scripts/unit_tests;
chmod +x /test_scripts/unit_tests;
";
    docker-compose exec hacienda sh -i --init-file /test_scripts/unit_tests;
}
alias hut=hut;

hat() {
    docker-compose exec hacienda sh -c "\
mkdir -p /test_scripts;
echo 'run-contexts -s /opt/hacienda/hacienda/acceptance/$1' > /test_scripts/acceptance_tests; chmod +x /test_scripts/acceptance_tests;
";
    docker-compose exec hacienda sh -i --init-file /test_scripts/acceptance_tests;
}
alias hat=hat;

hit() {
    docker-compose exec hacienda sh -c "\
mkdir -p /test_scripts;
echo 'run-contexts -s /opt/hacienda/hacienda/tests/integration/$1' > /test_scripts/integration_tests; chmod +x /test_scripts/integration_tests;
";
    docker-compose exec hacienda sh -i --init-file /test_scripts/integration_tests;
}
alias hit=hit;

hkill() {
    if (screen -ls | grep -q hacienda_dkcub)
    then
      echo "quitting old hacienda_dkcub";
      screen -S hacienda_dkcub -X -p 0 stuff $'\003';
      while (screen -ls | grep -q hacienda_dkcub)
      do
        sleep 5;
        echo "still quitting old hacienda_dkcub";
      done
      screen -S hacienda_dkcub -X quit;
    fi
}
alias hkill=hkill;

hrestart() {
    current_dir=$(pwd);
    cd $HACIENDA_PROJECT_DIR;
    hkill;
    echo "starting new hacienda_dkcub";
    screen -S hacienda_dkcub -d -m bash -c 'docker-compose up --build; exit';
    cd $current_dir;
}
alias hrestart=hrestart;
