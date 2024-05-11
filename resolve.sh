#!/bin/bash

# Function to execute commands and prompt for reboot
execute_commands() {
    # Step 1
    echo -e "nameserver 8.8.8.8\nnameserver 4.2.2.4" | sudo tee /etc/resolv.conf >/dev/null
    # Step 2
    sudo apt update
    # Step 3
    sudo apt install -y resolvconf
    # Step 4
    sudo systemctl start resolvconf.service
    # Step 5
    sudo systemctl enable resolvconf.service
    # Step 6
    echo -e "nameserver 8.8.8.8\nnameserver 4.2.2.4" | sudo tee /etc/resolvconf/resolv.conf.d/head >/dev/null
    # Step 7
    sudo systemctl restart resolvconf.service
    # Step 8
    sudo systemctl restart systemd-resolved.service

    # Ask whether to reboot
    read -p "Do you want to reboot the server? (y/n): " choice
    case "$choice" in
        y|Y ) sudo reboot;;
        n|N ) echo "No reboot requested.";;
        * ) echo "Invalid choice. No action taken.";;
    esac
}

# Run the function
execute_commands
