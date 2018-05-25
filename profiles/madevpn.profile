source $JG_MADE_SYSTEM/auths/madevpn/madevpn_unset.profile;

export MADEVPN_SCREEN_NAME=madevpn;

madevpn_kill() {
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

madevpn_start() {
    if (sudo screen -ls | grep -q $MADEVPN_SCREEN_NAME)
    then
        echo "madevpn already running...";
    else
        echo 'enter the base_password': 

        read -s base_password

        echo "thanks, now please wait up to 30 seconds for secret key to change..."

        source $JG_MADE_SYSTEM/auths/madevpn/madevpn.profile

        screen -S madevpn_secretkey -d -m watch -g -n1 'oathtool --totp -b $MADEVPN_GOOGLE_CODE | tee $JG_MADE_SYSTEM/auths/madevpn/.secret_key';

        source $JG_MADE_SYSTEM/auths/madevpn/madevpn_unset.profile;

        while (screen -ls | grep -q madevpn_secretkey)
        do
            sleep 1
        done

        echo $base_password > $JG_MADE_SYSTEM/auths/madevpn/.secret_base_password;

        unset base_password

        echo $(cat $JG_MADE_SYSTEM/auths/madevpn/.secret_base_password $JG_MADE_SYSTEM/auths/madevpn/.secret_key) \
        | tr -d " " > $JG_MADE_SYSTEM/auths/madevpn/.secret_password

        source $JG_MADE_SYSTEM/auths/madevpn/madevpn.profile

        echo $MADEVPN_USER_NAME > $JG_MADE_SYSTEM/auths/madevpn/.secret_user_name;

        source $JG_MADE_SYSTEM/auths/madevpn/madevpn_unset.profile;

        cat $JG_MADE_SYSTEM/auths/madevpn/.secret_user_name $JG_MADE_SYSTEM/auths/madevpn/.secret_password > $JG_MADE_SYSTEM/auths/madevpn/.secret-auth.txt;

        rm -f $JG_MADE_SYSTEM/auths/madevpn/.secret_base_password;
        rm -f $JG_MADE_SYSTEM/auths/madevpn/.secret_key;
        rm -f $JG_MADE_SYSTEM/auths/madevpn/.secret_password;
        rm -f $JG_MADE_SYSTEM/auths/madevpn/.secret_user_name;

        chmod 600 $JG_MADE_SYSTEM/auths/madevpn/.secret-auth.txt;

        sudo screen -S $MADEVPN_SCREEN_NAME -d -m openvpn --config $JG_MADE_SYSTEM/auths/madevpn/Linux-AWS-VPN.conf

        # the vpn needs a little time to connect before we delete the secret auth file
        sleep 5

        rm -f $JG_MADE_SYSTEM/auths/madevpn/.secret*;

        if (sudo screen -ls | grep -q $MADEVPN_SCREEN_NAME)
        then
            echo "madevpn successfully started :)";
        else
            echo "madevpn FAILED to start";
        fi
    fi
}
alias madevpn_start=madevpn_start;
