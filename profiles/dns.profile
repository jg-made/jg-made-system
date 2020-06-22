function dns() {
    echo "Clearing DNS in a bunch of different ways..."
    # run this command to flush dns cache:
    echo "sudo /etc/init.d/dns-clean restart"
    sudo /etc/init.d/dns-clean restart
    # or use:
    echo "sudo /etc/init.d/networking force-reload"
    sudo /etc/init.d/networking force-reload
    # Flush nscd dns cache:
    echo "sudo /etc/init.d/nscd restart"
    sudo /etc/init.d/nscd restart
    # If you wanted to refresh your settings you could disable and then run
    echo "sudo service network-manager restart"
    sudo service network-manager restart
}

function force_domain_through_vpn() {

    local destination=$(ifconfig | grep -A 1 tun0 | grep destination | grep -o '[^ ]*$')

    if [ -z "$destination" ]
    then
        echo "You don't appear to be on the VPN. Doing nothing..."
    else
        echo "Forcing $1 to route through VPN"
        dig $1 | \
            grep $1 | \
            grep -o -e '[0-9]*[.][0-9]*[.][0-9]*[.][0-9]*' | \
            grep -o -e '^[0-9]*[.][0-9]*' | \
            xargs -I prefixy echo prefixy.0.0 | \
            xargs -I ip_trans bash -c "\
sudo route del -net ip_trans gw $destination netmask 255.255.255.0 dev tun0 2>/dev/null;
sudo route add -net ip_trans gw $destination netmask 255.255.0.0 dev tun0;
"
    fi
}
