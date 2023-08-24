#!/bin/bash

IP_ADDRESS="10.12.34.1"
FAIL_THRESHOLD=10

failed_count=0

while true; do
    if ping -c 1 -W 1 $IP_ADDRESS >/dev/null; then
        echo "Ping successful"
        failed_count=0
    else
        echo "Ping failed"
        ((failed_count++))
    fi

    if [ $failed_count -ge $FAIL_THRESHOLD ]; then
        echo "Ping failed for the last $FAIL_THRESHOLD attempts. Taking action..."
        # restart networking service
        # 1. turn off networking
        nmcli networking off
        # 2. wait for 10 seconds
        sleep 10
        # 3. turn on networking
        nmcli networking on
    fi

    sleep 5 # Wait for a few seconds before the next ping
done
