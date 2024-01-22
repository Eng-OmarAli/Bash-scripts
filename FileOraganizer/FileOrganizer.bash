#!/bin/bash

# this script will create directories for (txt jpg pdf misc) 
# and then moves every file to its directory to help oragnize users files

# if condition to check for the path argument
if [ $# -ne 1 ]; then
    echo "FileOrganizer <target_directory>"
    exit 1
fi

# to extract target path where the script will oragnize the files 
path="$1"

# to check if the target path exists and is a directory
if [ ! -d "$path" ];then
    echo "Error: target directory $path doesn't exists."
    exit 1
fi

#make directories for each file type
mkdir -p "$path"/txt  "$path"/jpg "$path"/pdf "$path"/misc

# move each file to its corresponding folder
mv "$path"/*.txt "$path"/txt
mv "$path"/*.jpg "$path"/jpg
mv "$path"/*.pdf "$path"/pdf

# for loop will move all remaining files to misc
for file in "$path"/*; do
    if [ -f "$file" ];then
        mv "$path"/"$file" "$path"/misc
    fi
done    

echo "operation ran successfully all files are organized"

