#!/bin/bash
#Function to handle error messages
handle_error(){
echo "Error: $1"
exit 1
}
#Default values for src and dat arguments
src="./"
dat="newest"
#Check for arguments
if [ $# -eq 0 ]; then
handle_error "No arguments provided"
else
for arg in "$@"; do
if [[ $arg == src:* ]]; then
src="${arg:4}"
elif [[ $arg == dat:* ]]; then
dat="${arg:4}"
else
handle_error "Invalid argument: $arg"
fi
done
fi
#Check if src directory exists
if [ ! -d "$src" ]; then
handle_error "Directory not found: $src"
fi
#Get the list of files and directories in the src directory
list=$(find "$src" -type f -or -type d)
#Check the number of elements in the list
if [ $(echo "$list" | wc -l) -lt 10 ]; then
echo "$list"
else
# Sort the list by modification time
if [ "$dat" == "newest" ]; then
list=$(echo "$list" | xargs ls -lt | awk '{print $9}')
elif [ "$dat" == "oldest" ]; then
list=$(echo "$list" | xargs ls -ltr | awk '{print $9}')
else
handle_error "Invalid value for dat argument: $dat"
fi
# Get the first 10% of elements in the list
count=$(echo "$list" | wc -l)
count=$((count / 10))
list=$(echo "$list" | head -n $count)
echo "$list"
fi