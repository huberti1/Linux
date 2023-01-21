#!/bin/bash

# This script displays a list of 10% of the elements in a specified directory.
# Elements include both files and directories.
# It accepts up to two arguments: src:... and dat:..., and their order is not important.
# Argument src: specifies the directory and path, e.g. src:/home/Adam
# Argument dat: specifies the sorting of elements:
#    dat:oldest sorts by oldest
#    dat:newest sorts by newest (default)
# The script accepts the following combinations of arguments:
#    src, dat
#    src
#    dat
#    If no arguments are provided, it returns an error message.
#    If the dat: argument is not provided, it defaults to sorting by newest.
#    If the src: argument is not provided, it defaults to the current directory.
# If the list has less than 10 elements, the script will display only one element.

# Check for the presence of arguments
if [ $# -eq 0 ]; then
  echo "Error: No arguments provided."
  exit 1
fi

# Initialize variables
src_dir=`pwd` # Default to current directory
dat_arg="newest" # Default to sorting by newest

# Parse arguments
for arg in "$@"
do
  case $arg in
    src:*)
      src_dir="${arg#src:}"
      ;;
    dat:oldest)
      dat_arg="oldest"
      ;;
    dat:newest)
      dat_arg="newest"
      ;;
  esac
done

# Get the list of elements in the specified directory
elements=`ls -U $src_dir`

# Sort the list of elements
if [ $dat_arg == "oldest" ]; then
  elements=`ls -Utr $src_dir`
else
  elements=`ls -U $src_dir`
fi

# Get the number of elements
num_elements=`echo "$elements" | wc -l`

# Calculate the number of elements to display
num_to_display=`echo $((num_elements / 10 + 1))`

# Display the list of elements
echo "$elements" | head -n $num_to_display