#!/bin/bash

SITE_ENV=$1
for SERVER in $( aht @$SITE_ENV ssh --all hostname | grep "\[" | cut -c2- | awk -F"." '{print $1}' | sort -V)
do echo "$SERVER returned from reboot/relaunch at:"  
aht @$SITE_ENV ssh $SERVER sudo "uptime -s"
done
