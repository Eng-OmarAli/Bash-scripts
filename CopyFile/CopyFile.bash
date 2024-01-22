#!/bin/bash

#check for 2 arguments

if [ $# -ne 2 ]; then
	echo "$0 <source_file> <destination_path>"
	exit 1
fi

# to extract source and destination paths
source_file="$1"
destination_path="$2"

# to Check if the source file exists
if [ ! -f "$source_file" ]; then
  echo "Error: Source path '$source_file' is not found."
  exit 1
fi

# to check for destination path
if [ ! -d "$destination_path" ]; then
#if it does not exist make a new directory
 mkdir -p "$destination_path"
fi

#copy files
cp "$source_file" "$destination_path"

echo "operation successful: file copied to $destination_path."

