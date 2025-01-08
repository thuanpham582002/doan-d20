#!/bin/bash

# Define the hostnames and their corresponding IPs
declare -A hosts=(
    ["gitlab.noroom113.com"]="192.168.105.20"
    ["database.noroom113.com"]="192.168.105.21"
    ["registry.noroom113.com"]="192.168.105.22"
    ["argocd.noroom113.com"]="192.168.105.49"
)

# Backup /etc/hosts before making changes
sudo cp /etc/hosts /etc/hosts.bak

# Loop through the hostnames and handle adding/updating entries
for hostname in "${!hosts[@]}"; do
    ip="${hosts[$hostname]}"

    if grep -q "$hostname" /etc/hosts; then
        current_ip=$(grep "$hostname" /etc/hosts | awk '{print $1}')

        if [[ "$current_ip" != "$ip" ]]; then
            echo "Updating IP for $hostname from $current_ip to $ip"
            sudo sed -i.bak "/$hostname/s/$current_ip/$ip/" /etc/hosts
        else
            echo "$hostname is already set to $ip, skipping."
        fi
    else
        echo "Adding $ip $hostname to /etc/hosts"
        echo "$ip $hostname" | sudo tee -a /etc/hosts > /dev/null
    fi
done

echo "Hosts file update complete."