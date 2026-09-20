#!/bin/bash

# This script learns about two ways to expand variables in bash: $var and ${var}.

# 1. Assign a value to a variable.
NAME='guy'

# 2. Display the value of the variable using $var.
echo "Hello $NAME"

# 3. Display the value of the variable using ${var}.
echo "Hello ${NAME}"

# Two ways is good in simple cases, but when you want to use some advanced features, you need to use ${var}.

# 4.1 Demonstrate that ${var} allows you to append text to the variable, $var does not.
echo "-------------------------------------"
echo "Many ${NAME}s are here!" #Output: Many guys are here!
echo "Many $NAMEs are here!" #Output: Many {null} are here! // This is because $NAMEs is treated as a single variable name, which does not exist, so it expands to an empty string.


# 4.2 Demonstrate that ${var} allows you append text to the variable, $var does not. (2nd example)
name2="Alice"
echo "$name2_suffix"    # → NULL! (bash search for "name_suffix", not existing variable, so it expands to an empty string)
echo "${name2}_suffix"  # → Alice_suffix (bash search for "name2", which exists, and then appends "_suffix" to it)

# 5. ${var} allows you to user some advanced features:

# 5.1 Default value if variable is unset or null.
echo "-------------------------------------"
unset var1
default_value="default"
echo "${var1:-default_value}" #Output: default_value (var1 is unset, so the default value is used)

var1="value"
echo "${var1:-default_value}" #Output: value (var1 is set, so the value of var1 is used)

# 5.2 Get the length of the variable.
echo "-------------------------------------"
var2="Hello"
echo "${#var2}" #Output: 5 (The length of the string "Hello")

# 5.3 Substring extraction.
echo "-------------------------------------"
var3="Hello World"
echo "${var3:0:5}" #Output: Hello (Extracts the substring starting at index 0 with length 5)

# 5.4 Replace a substring with another substring.
echo "-------------------------------------"
var4="Hello World"
echo "${var4/World/Dev001}" #Output: Hello Dev001 (Replaces the first occurrence of "World" with "Dev001")




