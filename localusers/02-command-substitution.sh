#!/bin/bash

# This script learns the difference between `cmd` and $(cmd).

# 1. Both can be used to capture command output.
date1=`date`
date2=$(date)

echo "$date1"
echo "$date2"

# 2. With simple commands, both work the same.
current_dir=`pwd`
current_dir2=$(pwd)

echo "$current_dir"
echo "$current_dir2"

# 3.1 $(cmd) is easier to use with nested commands.
result=$(basename $(pwd))
echo "$result"

# 3.2 `cmd` is harder to use with nested commands.
echo "-------------------------------------"
# You need to escape the inner backticks with a backslash, which can be confusing and hard to read (especially when there are multiple levels of nesting).
result1=`basename \`pwd\``
echo "$result1"

# 4. Prefer $(cmd) in modern shell scripts.
# It is easier to read, easier to nest, and easier to maintain.
