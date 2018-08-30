#!/bin/bash
path="$( cd "$(dirname "$0")" ; pwd -P )"
power=$(pmset -g batt | grep -o '[0-9]*%')
power=${power//[!0-9]/}

if [ "$power" -lt 20 ]
then
	sh $path/alert.sh
fi
