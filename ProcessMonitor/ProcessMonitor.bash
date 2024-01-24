#!/bin/bash

LOG_FILE="script_logs.txt"
CONF_FILE="ProcessMonitor.conf"

# Function to log messages
log() {
    local log_message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$timestamp: $log_message" >> "$LOG_FILE"
}

# logging the start point of the script
log "Info message: starting the script"

if [ -f $CONF_FILE ]; then
    source $CONF_FILE
else
    echo "ProcessMonitor.conf was not found."
    log  "ProcessMonitor.conf was not found."
    exit 1
fi

while true; do

    # alert user if CPU or Memory threshold reached
    ps -eo pcpu | awk -v CPU_threshold="$CPU_ALERT_THRESHOLD" '$1 > CPU_threshold {print "Alert: A process used CPU beyond the threshold"}'
    ps -eo pcpu | awk -v Mem_threshold="$MEMORY_ALERT_THRESHOLD" '$1 > Mem_threshold {print "Alert: A process used Memory beyond the threshold"}'

    echo "*************** Process Monitor ***************"

    echo "0: Exit"
    echo "1: Process Information"
    echo "2: Kill a process"
    echo "3: Process Statistics"
    echo "4: Real-time Monitoring"
    echo "5: Search and Filter"

    echo "***********************************************"
   
    read -p "Enter your operation: " operation

    case "${operation}" in
        0)  # exit
            # logging the end point of the script
            log "Info message: script ended successfully"
            exit 0;
        ;;
        1)  # Process Information:
            read -p "Enter the PID of the process: " PID

            if ps -p "$PID" >/dev/null; then
                ps aux | grep "$PID"

                # Logging Process Information
                log "User chose Process Information: "
                log "PID: $PID"
                sleep 3
            else
                echo "Process PID not found"
                sleep 3
            fi
        ;;
        2)  # Kill a Process:
            read -p "Enter the PID of the process: " PID

            if ps -p "$PID" >/dev/null; then
                kill "$PID"
                echo "Process $PID terminated."

                # Logging Process Information
                log "User chose to Kill a Process:"
                log "PID: $PID"
                sleep 3
            else
                echo "Process PID not found"
                sleep 3
            fi

        ;;
        3)  # Process Statistics:
            echo "Total number of Processes $(ps aux --no-header | wc -l)"
            echo "Memory Usage: "
            free -h
            echo "CPU load: $(uptime)" 
            sleep 3        
        ;;
        4)  # Real-time Monitoring:
            echo "press q: to exit from Real-time Monitoring"
            echo "you can adjust refresh time from .conf file."
            sleep 3
            # will refresh every $UPDATE_INTERVAL sec.
            top -d $UPDATE_INTERVAL
            
        ;;
        5)  # Search and Filter:
            read -p "Enter a keyword to search for: " keyword
            ps aux | grep "$keyword"
            sleep 3
        ;;
        *)  # no valid input from user
            echo "Invalid operation. Enter only a number from 0 to 5."
        ;;
    esac
    
done

