#!/bin/bash

path="$( cd "$(dirname "$0")" ; pwd -P )"

account_sid=$(<$path/.twillio_sid)
auth_token=$(<$path/.twillio_auth)
available_number=$(<$path/.twillio_num)
your_number=$(<$path/.target_num)

power=$(pmset -g batt | grep -o '[0-9][0-9]%')

result=$(curl -X POST -d "Body=Your Mac device battery is at ${power}" \
    -d "From=${available_number}" -d "To=${your_number}" \
    "https://api.twilio.com/2010-04-01/Accounts/${account_sid}/Messages" \
    -u "${account_sid}:${auth_token}" --write-out '%{http_code}' --silent --output /dev/null)

if [ $result -eq 201 ]
then
	echo "$result: Successfully Sent Status to $your_number"
else
	echo "$result: Failed to Send Status:"	
fi
