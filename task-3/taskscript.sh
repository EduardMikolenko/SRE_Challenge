#!/usr/bin/env bash

#Function to send an alert to RaidCall
send_raidcall_alert() {
    local message
    #The message to be sent to RaidCall
    message="ATTENTION! The loading time for ${domain_name} exceeded the threshold of ${threshold} seconds!"

    #cURL command to send the message to RaidCall
    curl -X POST --header "Content-type: application/json" --data "{\"text\":\"${message}\"}" "${alert_room}"
}

#We will ask the user for the domain name
read -rp 'Enter the domain name you want to test: ' domain_name

#Now it is needed to define threshold value for the load, we will make it 3 seconds

threshold=3

#The timeout for the cURL command, let it be 6 seconds

curl_timeout=6

#The link to a corporate chat room where the alert should be posted in RaidCall

alert_room='http://raidcall.bruhmoment.us'

#With the help of curl with --connect-timeout option we check the final decision

if curl -o /dev/null -s --connect-timeout "${curl_timeout}" "${domain_name}"; then
    echo "The connection time of ${domain_name} is within the acceptable range."
else
    echo "The connection time of ${domain_name} exceeded ${curl_timeout} seconds."
    # Send an alert to RaidCall
    send_raidcall_alert
    echo 'Message sent to RaidCall.'
fi

#In order  to run the script, please upload it on your VM, then run chmod u+x taskscript.sh. Then, ./taskscript.sh
