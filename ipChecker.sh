#!/bin/bash

# List of IPs to check
#ip_list=("x.x.x.x" "x.x.x.x")
ip_list=("x.x.x.x" "x.x.x.x" "x.x.x.x")

# Function to check if an IP is available
check_ip() {
    local ip=$1
    if ping -c 1 -W 1 $ip &> /dev/null; then
        return 1  # IP in use
    else
        return 0  # IP available
    fi
}

# Loop through the list of IPs
for ip in "${ip_list[@]}"; do
    if check_ip $ip; then
        echo "IP $ip is available."
    fi
done

echo "No available IPs found."
exit 1
