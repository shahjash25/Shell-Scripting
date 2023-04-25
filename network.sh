# Networking Tool
# !/bin/bash

# Features:
# 1. Checks connectivity of network
# 2. Logs the result into a file
# 3. Sends alert mail if email is down


# Set the IP address of the host to monitor
# an ip address has been selected to montitor the host
IP_ADDRESS="www.codeforces.com"

# A certain time interval needs to be send
# After that the system checks for it
# Set the monitoring interval in seconds
MONITOR_INTERVAL=5

# using -i option we can set packet size
# ICMP header ke header ke liye 64 hota hai
# other sizes are 56...
# Set the packet size for ping requests
PACKET_SIZE=64

# Set the log file path
LOG_FILE="/home/shahjash25/jash/log.txt"

# Function to log the network status
log_network_status() {
    # Append the network status to the log file
    echo "$(date): $1" >> $LOG_FILE
}

# Set the number of packets to send in each ping request
NUM_PACKETS=3

# Set the email address to send the alert to
EMAIL="shahjash2512@gmail.com"

# Function to send an email alert
send_email_alert() {
    # mail command is used to send alert if network is down
    echo "Network is DOWN" | mail -s "Network Alert" $EMAIL
}


# echo is used for printing
# Function to monitor the network
monitor_network() {
    while true
    do
        # Use the ping command to check network connectivity
        ping -c $NUM_PACKETS -s $PACKET_SIZE $IP_ADDRESS > /dev/null
        if [ $? -eq 0 ]
        then
            echo "$(date): Network is UP"
            log_network_status "Network is UP"
        else
            echo "$(date): Network is DOWN"
            log_network_status "Network is DOWN"
            send_email_alert
        fi
        sleep $MONITOR_INTERVAL
    done
}

monitor_network