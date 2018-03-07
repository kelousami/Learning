#!/bin/bash

# This script takes a CSV file as input.
# The CSV file may contain multiple lines.
# The CSV file may contain lines with more columns than a certain limit.
# The purpose of this script is to remove the lines that exceed the limit. 

set -e

# Arguments
input="$1"
columns_limit="$2"

# Outputs
output="$1".processed

# Variables
counter=0

while read line; do
 counter=`awk -F ',' '{print NF-1}' <<< $line`
 if [ $counter -eq "$columns_limit" ] 
 then 
  echo "$line" >> "$output"
 fi
done < "$1"

exit 0
