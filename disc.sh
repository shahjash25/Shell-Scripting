#!/bin/bash

# System monitoring tool

# Display usage information
function display_usage {
    echo "Usage: $0 [-c cpu_threshold] [-m mem_threshold] [-d disk_threshold]"
    echo "  -c cpu_threshold    CPU usage threshold percentage (default: 80)"
    echo "  -m mem_threshold    Memory usage threshold percentage (default: 80)"
    echo "  -d disk_threshold   Disk usage threshold percentage (default: 80)"
    exit 1
}

# Set default values if not provided
cpu_threshold=0
mem_threshold=0
disk_threshold=0

# Parse command line arguments
while getopts ":c:m:d:" opt; do
    case $opt in
        c) cpu_threshold=$OPTARG ;;
        m) mem_threshold=$OPTARG ;;
        d) disk_threshold=$OPTARG ;;
        \?) echo "Invalid option: -$OPTARG" >&2
            display_usage ;;
        :) echo "Option -$OPTARG requires an argument" >&2
            display_usage ;;
    esac
done

# Check CPU usage
check_cpu_usage() {
    cpu_usage=$(top -bn1 | grep load | awk '{printf "%.2f\n", $(NF-2)*100}')
    cpu_usage=${cpu_usage%.*}
    if (( $cpu_usage > $cpu_threshold )); then
        echo "High CPU usage detected: ${cpu_usage}%"
    else
        echo "cpu usage under check"
    fi
}

# Check memory usage
check_mem_usage() {
    mem_usage=$(free | awk '/Mem/{printf "%.2f\n", $3/$2*100}')
    mem_usage=${mem_usage%.*}
    if (( $mem_usage > $mem_threshold )); then
        echo "High memory usage detected: ${mem_usage}%"
    else
        echo "memory usage is under control"
    fi
}

# Check disk usage
check_disk_usage() {
    disk_usage=$(df -h / | awk '/\//{print $(NF-1)}')
    disk_usage=${disk_usage%\%}
    if (( $disk_usage > $disk_threshold )); then
        echo "High disk usage detected: ${disk_usage}%"
    else
        echo "disk usage is under control"
    fi
}

check_cpu_usage
check_mem_usage
check_disk_usage
