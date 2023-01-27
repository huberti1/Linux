#!/bin/bash

# Set default values for arguments
src_dir="./"
sort_order="newest"

# Check for and parse arguments
for arg in "$@"; do
  case $arg in
    src:*)
      src_dir="${arg#src:}"
      ;;
    dat:*)
      sort_order="${arg#dat:}"
      ;;
  esac
done

# Get list of files and directories in the specified directory (including subdirectories)
file_list=$(find "$src_dir" -maxdepth 1 -type f -or -type d)

# Sort the list based on the specified order
if [ "$sort_order" == "oldest" ]; then
  file_list=$(echo "$file_list" | sort -n)
else
  file_list=$(echo "$file_list" | sort -nr)
fi

# Get the number of items in the list
num_items=$(echo "$file_list" | wc -l)

# If there are less than 10 items, only display one item
if [ "$num_items" -lt 10 ]; then
  echo "$file_list" | head -n 1
else
  # Display the first 10% of items
  echo "$file_list" | head -n $(($num_items/10))
fi