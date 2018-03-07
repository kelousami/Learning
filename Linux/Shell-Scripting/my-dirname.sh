#!/bin/bash

set -e

file=$0

if [ -n "${file##*/*}" ]; then
    echo "1"
    echo "."  
else
    echo "2"
    echo "${file%/*}"
fi

echo "using dirname"
dirname $file


