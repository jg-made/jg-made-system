function dns() {
    # run this command to flush dns cache:
    sudo /etc/init.d/dns-clean restart
    # or use:
    sudo /etc/init.d/networking force-reload
    # Flush nscd dns cache:
    sudo /etc/init.d/nscd restart
    # If you wanted to refresh your settings you could disable and then run
    sudo service network-manager restart
}
