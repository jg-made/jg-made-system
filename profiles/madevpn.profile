source $JG_MADE_SYSTEM/auths/unset/madevpn.profile;

export MADEVPN_SCREEN_NAME=madevpn;

function maybe_i_should_stop_using_ubuntu() {
    resolvectl domain tun0 consul
}

function madevpn_check() {
    if [ $(curl -m 10 -s -o /dev/null -w "%{http_code}" https://portus.made.com) -eq 200 ]
    then
        echo "madevpn is up and running :)";
    else
        echo "madevpn is down";
    fi
}
alias madevpn_check=madevpn_check

function madevpn_kill() {
    if (sudo screen -ls | grep -q $MADEVPN_SCREEN_NAME)
    then
        echo "killing $MADEVPN_SCREEN_NAME, please wait...";
        # send ctrl+c to the container
        sudo screen -S $MADEVPN_SCREEN_NAME -X -p 0 stuff $'\003';
        while (sudo screen -ls | grep -q $MADEVPN_SCREEN_NAME)
        do
            sleep 1;
        done
        sudo screen -S $MADEVPN_SCREEN_NAME -X quit;
    fi
}
alias madevpn_kill=madevpn_kill;

function madevpn_start() {
    if (sudo screen -ls | grep -q $MADEVPN_SCREEN_NAME)
    then
        echo "madevpn already running...";
    else
        echo "please wait up to 30 seconds for secret key to change..."

        source <(sudo cat $JG_MADE_SYSTEM/auths/madevpn/madevpn.profile)

        sudo screen -S madevpn_secretkey -d -m zsh -c "source $JG_MADE_SYSTEM/auths/madevpn/madevpn.profile & watch -g -n1 'oathtool --totp -b $MADEVPN_GOOGLE_CODE | sudo tee $JG_MADE_SYSTEM/auths/madevpn/.secret_key'";

        source $JG_MADE_SYSTEM/auths/unset/madevpn.profile;

        while (screen -ls | grep -q madevpn_secretkey)
        do
            sleep 1
        done

        unset base_password

        echo $(sudo cat $JG_MADE_SYSTEM/auths/madevpn/.secret_base_password $JG_MADE_SYSTEM/auths/madevpn/.secret_key) \
        | tr -d " " | sudo tee $JG_MADE_SYSTEM/auths/madevpn/.secret_password > /dev/null

        source <(sudo cat $JG_MADE_SYSTEM/auths/madevpn/madevpn.profile)

        echo $MADEVPN_USER_NAME | sudo tee $JG_MADE_SYSTEM/auths/madevpn/.secret_user_name > /dev/null;

        source $JG_MADE_SYSTEM/auths/unset/madevpn.profile;

        sudo cat $JG_MADE_SYSTEM/auths/madevpn/.secret_user_name $JG_MADE_SYSTEM/auths/madevpn/.secret_password | sudo tee $JG_MADE_SYSTEM/auths/madevpn/.secret-auth.txt > /dev/null;

        sudo rm -f $JG_MADE_SYSTEM/auths/madevpn/.secret_key;
        sudo rm -f $JG_MADE_SYSTEM/auths/madevpn/.secret_password;
        sudo rm -f $JG_MADE_SYSTEM/auths/madevpn/.secret_user_name;

        sudo chmod 600 $JG_MADE_SYSTEM/auths/madevpn/.secret-auth.txt;

        echo "got new secret key. Trying to start $MADEVPN_SCREEN_NAME now"

        sudo screen -S $MADEVPN_SCREEN_NAME -d -m openvpn --config $JG_MADE_SYSTEM/auths/madevpn/Linux-AWS-VPN.conf

        # the vpn needs a little time to connect before we delete the secret auth file
        sleep 8

        sudo rm -f $JG_MADE_SYSTEM/auths/madevpn/.secret*;

        # the vpn needs a little time before we test it
        sleep 5
        madevpn_check

        # the tun0 interface might have a different name different machines.
        maybe_i_should_stop_using_ubuntu
    fi
}
alias madevpn_start=madevpn_start;
