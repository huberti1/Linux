#!/bin/bash

# Check for the presence of arguments
if [ $# -eq 0 ]; then
    echo "Error: No arguments provided"
    exit 1
fi

# Set default values for src and dat
src=$(pwd)
dat="newest"

# Parse arguments
for arg in "$@"; do
    case $arg in
        src:*) src=${arg#src:} ;;
        dat:oldest) dat="oldest" ;;
        dat:newest) dat="newest" ;;
    esac
done

# Check if the src directory exists
if [ ! -d "$src" ]; then
    echo "Error: $src is not a valid directory"
    exit 1
fi

# Get list of files and directories in the src directory
files=$(find "$src" -maxdepth 1 -type f -or -type d)

# Sort files based on dat argument
if [ "$dat" == "oldest" ]; then
    files=$(echo "$files" | sort -n)
else
    files=$(echo "$files" | sort -nr)
fi

# Take 10% of the files
files_count=$(echo "$files" | wc -l)
files_count=$((files_count/10))
if [ $files_count -eq 0 ]; then
    files_count=1
fi
files=$(echo "$files" | head -n "$files_count")

# Print the result
echo "$files"