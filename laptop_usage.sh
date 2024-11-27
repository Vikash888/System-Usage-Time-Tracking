#!/bin/bash

# Set strict mode for better error handling
set -euo pipefail

# Define the log file to store the start time and date
LOG_FILE="${HOME}/.laptop_usage.log"

# Function to log errors
log_error() {
    echo "ERROR: $1" >&2
}

# Ensure the log file is writable
touch "$LOG_FILE" || {
    log_error "Cannot create or write to log file $LOG_FILE"
    exit 1
}

# Get today's date in YYYY-MM-DD format
TODAY=$(date +%Y-%m-%d)

# Initialize variables
START_TIME=0
LOG_DATE=""

# Read existing log file contents
if [ -s "$LOG_FILE" ]; then
    # Use read with fallback to handle potential file read errors
    read -r LOG_DATE START_TIME < "$LOG_FILE" || {
        log_error "Failed to read log file"
        # Reset log file if reading fails
        START_TIME=$(date +%s)
        echo "$TODAY $START_TIME" > "$LOG_FILE"
    }
else
    # If file is empty, initialize with current time
    START_TIME=$(date +%s)
    echo "$TODAY $START_TIME" > "$LOG_FILE"
fi

# Check if today is different from the logged date
if [ "$LOG_DATE" != "$TODAY" ]; then
    echo "New day detected. Resetting start time..."
    START_TIME=$(date +%s)
    # Update log file with today's date and new start time
    echo "$TODAY $START_TIME" > "$LOG_FILE"
fi

# Get the current time in seconds
CURRENT_TIME=$(date +%s)

# Calculate the total usage time in seconds for today
USAGE_TIME_SECONDS=$((CURRENT_TIME - START_TIME))

# Calculate total usage time in hours, minutes, and seconds
USAGE_TIME_HOURS=$((USAGE_TIME_SECONDS / 3600))
USAGE_TIME_MINUTES=$(((USAGE_TIME_SECONDS % 3600) / 60))
USAGE_TIME_REMAINING_SECONDS=$((USAGE_TIME_SECONDS % 60))

# Output total laptop usage time
printf "Laptop Usage Today:\n"
printf "Time: %02d hours, %02d minutes, %02d seconds\n" \
    "$USAGE_TIME_HOURS" "$USAGE_TIME_MINUTES" "$USAGE_TIME_REMAINING_SECONDS"

# Display start time and current time for debugging
printf "\nDebug Information:\n"
printf "Start time: %s\n" "$(date -d "@$START_TIME" '+%Y-%m-%d %H:%M:%S')"
printf "Current time: %s\n" "$(date '+%Y-%m-%d %H:%M:%S')"
