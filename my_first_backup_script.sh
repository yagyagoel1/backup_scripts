#!/bin/bash

#check to make sure the user haas entered exactly two arguments
if [ $# -ne 2 ]
then 
	echo "usage: backup.sh <source_directory> <target_directory>"
	echo "please try again."
	exit 1
fi

# check to see if rsync is installed 
if ! command -v rsync > /dev/null 2>&1
then 
	echo "this script requires rsync to be installed "
	echo "plese use your distributions package manager to install"
	exit 2
fi
#capture the current date and store it in the format yyyy-mm-dd
current_date=$(date +%Y-%m-%d)

rsync_options="-avb --backup-dir $2/current_date --delete --dry-run"

$(which rsync) $rsync_options $1 $2/current >> backup_$current_date.log

