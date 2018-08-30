#!/bin/bash
path="$( cd "$(dirname "$0")" ; pwd -P )"

read -p 'Twillio SID: ' account_sid
read -p 'Twillio Token: ' auth_token
read -p 'Number Recieving Alerts: ' target_num

echo $account_sid > $path/.twillio_sid
echo $auth_token > $path/.twillio_auth
echo $target_num > $path/.target_num

available_number=$(<$path/.twillio_num)

if [ -z "$available_number" ]
then
	available_number=`curl -X GET \
	    "https://api.twilio.com/2010-04-01/Accounts/${account_sid}/AvailablePhoneNumbers/US/Local"  \
	    -u "${account_sid}:${auth_token}" | \
	    sed -n "/PhoneNumber/{s/.*<PhoneNumber>//;s/<\/PhoneNumber.*//;p;}"` \
	    && echo $available_number 

	curl -X POST -d "PhoneNumber=${available_number}" \
	    "https://api.twilio.com/2010-04-01/Accounts/${account_sid}/IncomingPhoneNumbers" \
	    -u "${account_sid}:${auth_token}"

	echo $available_number > $path/.twillio_num
else
	echo Using Existing Twillio Number: $available_number
fi

echo "Setup Complete with $available_number alerting $target_num"
