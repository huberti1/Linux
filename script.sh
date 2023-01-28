#!/bin/bash

# define default values for src and dat variables
src="./"
dat="newest"

# loop through arguments passed to the script
for arg in "$@"
do
    # check if arg starts with "src:"
    if [[ $arg == src:* ]]; then
        # remove "src:" from the arg and assign the value to src variable
        src=${arg:4}
    fi
    # check if arg starts with "dat:"
    if [[ $arg == dat:* ]]; then
        # remove "dat:" from the arg and assign the value to dat variable
        dat=${arg:4}
    fi
done

# check if src directory exists
if [ ! -d "$src" ]; then
    echo "Error: $src is not a valid directory"
    exit 1
fi

# get the list of files and directories in the src directory
files_and_dirs=($src/*)

# check if files_and_dirs array is not empty
if [ ${#files_and_dirs[@]} -eq 0 ]; then
    echo "Error: $src is empty"
    exit 1
fi

# sort the list of files and directories based on the value of dat variable
if [ $dat == "oldest" ]; then
    files_and_dirs=($(for f in "${files_and_dirs[@]}"; do stat -c "%Y %n" "$f"; done | sort -n | awk '{$1=""; print $0}'))
else
    files_and_dirs=($(for f in "${files_and_dirs[@]}"; do stat -c "%Y %n" "$f"; done | sort -nr | awk '{$1=""; print $0}'))
fi

# calculate the number of files and directories to display
if [ ${#files_and_dirs[@]} -ld 10 ]; then
  num_to_display=1
else
  num_to_display=$(echo "(${#files_and_dirs[@]} * 0.1)" | bc | awk '{print int($1)}')
fi

# check if num_to_display is greater than the number of files and directories
if [ $num_to_display -gt ${#files_and_dirs[@]} ]; then
    num_to_display=${#files_and_dirs[@]}
fi

# display the first num_to_display files and directories
for ((i=0; i<num_to_display; i++)); do
    # check if file or directory exists
    if [ -e "${files_and_dirs[i]}" ]; then
        echo ${files_and_dirs[i]}
    fi
done