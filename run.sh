#!/bin/bash

# Select all the files in current dir that ends with '.v'
args="$(ls | grep ".*\.v" | xargs)"
iverilog $args
echo -e "\nExecuting a.out\n"
./a.out
echo -e "\nRemoving a.out\n"
rm a.out