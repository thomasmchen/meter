#!/bin/bash
path="$( cd "$(dirname "$0")" ; pwd -P )"
power=$(pmset -g batt | grep -o '[0-9][0-9]%')
power=${power//[!0-9]/}

if [ "$power" -lt 20 ]
then
	echo "Battery at $power%, alerting user..."
	sh $path/alert.sh
else
	echo "Battery at $power%, no alert needed."
fi
