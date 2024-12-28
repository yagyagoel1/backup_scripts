#!/bin/bash

<<readme
this is a script to backup with 5 day rotation 

usage:
./backup.sh <path to your source > <path to backup folder>
readme

function display_usage {
    echo "usage: ./backup.sh <path to your source > <path to backup folder>"
}

if [ $# -ne 2 ]; then
    display_usage
    exit 1
fi

source_dir=$1
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')
backup_dir=$2

function create_backup {

	zip -r "${backup_dir}/backup_${timestamp}.zip" "${source_dir}" > /dev/null 
	if [ $? -ne 0 ]; then
		echo "backup zipping failed for ${timestamp}"
		exit 1
	else
		echo "backup generated successfully for ${timestamp}"
	fi
}
function perform_rotation {
	backups=($(ls -t "${backup_dir}/backup_"*.zip 2>/dev/null))
	echo "${backups[@]}"
	if [ "${#backups[@]}" -gt 5 ]; then
		echo "performing rotation for  5 days"
		backups_to_remove=("${backups[@]:5}")
		echo "${backups_to_remove[@]}"

		for backup in "${backups_to_remove[@]}";
		do 
			rm -f ${backup}
		done
	fi
}
create_backup

perform_rotation
	
