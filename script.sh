#!/bin/bash

# the directory to display the elements from
src="./"

# the order of elements to display
dat="newest"

# loop through arguments
for arg in "$@"
do
    # check if argument is specifying the source directory
    if [[ $arg == src:* ]]; then
        src=${arg#src:}
    fi

    # check if argument is specifying the sort order
    if [[ $arg == dat:* ]]; then
        dat=${arg#dat:}
    fi
done

# check if source directory exists
if [ ! -d "$src" ]; then
    echo "Error: The source directory does not exist."
    exit 1
fi

# get the list of elements in the source directory
elements=( $(find "$src" -maxdepth 1 -printf '%T+ %p\n' | sort -r) )

# check if there are less than 10 elements
if [ ${#elements[@]} -lt 10 ]; then
    for element in "${elements[@]}"
    do
        echo ${element#* }
    done
    exit 0
fi

# determine the number of elements to display
num_elements=$(( ${#elements[@]} / 10 ))

# check if sort order is oldest
if [ "$dat" == "oldest" ]; then
    # loop through the elements in reverse order
    for (( i=${#elements[@]}-1; i >= ${#elements[@]}-$num_elements; i-- )); do
        echo ${elements[i]#* }
    done
else
    # loop through the elements
    for (( i=0; i < num_elements; i++ )); do
        echo ${elements[i]#* }
    done
fi
