#!/bin/sh

# Usage: ./crit.sh <app.env> [<impacted_url>]
# Example: ./crit.sh eesbhosale1.dev sourabh.hitzcrafty.co.in

# This script fetches application infrastructure details, server load, useful sumo links, domain check,
# and performs a DNS check for an impacted URL.

# Function to display section separators
separator() {
    echo "----------------------------------------"
}

if [ $# -lt 1 ]; then
    echo "Usage: $0 <app.env> [<impacted_url>]"
    exit 1
fi

app_env="$1"
impacted_url="$2"

# Display application information
echo "---- APPLICATION INFORMATION ----"
separator
aht "@$app_env" a:i | grep -B 9999999 'Entitlements:'
echo

# Display server load details
echo "---- SERVER LOAD ----"
separator
aht "@$app_env" a:load
echo

# Display useful SUMO Links
echo "---- PANIC LINKS ----"
separator
aht "@$app_env" panic -l
echo

# Perform domain check for provided environment
echo "---- DOMAIN CHECK ----"
separator
aht "@$app_env" do:c
echo

# Perform quick DNS check for the impacted URL
if [ -n "$impacted_url" ]; then
    echo "---- DNS CHECK OF IMPACTED URL ----"
    separator
    dig +short "$impacted_url"
    echo
fi

# End of the script

