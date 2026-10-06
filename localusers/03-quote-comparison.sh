#!/bin/bash

# This script learns about single and double quotes.

# 1. Single quotes -> Literal string. No variable expansion.
name='John'
echo 'Hello $name' #Output: Hello $name (No variable expansion)
echo 'Hello ${name}' #Output: Hello ${name} (No variable expansion)

# 2. Double quotes -> Variable expansion occurs.
echo "-------------------------------------"
echo "Hello $name" #Output: Hello John (Variable expansion occurs)
echo "Hello ${name}" #Output: Hello John (Variable expansion occurs)

# Double quotes allow:
# variable expansion $var or ${var}
# command substitution $(var) or `var`
# escape sequences like \n, \t, etc.
# special variables like $?, $#, $@, etc.

# when using double quotes, when using single quotes ?

# when you want to use a literal string, use single quotes.

# 3.1 Demonstrate that single quotes -> literal string. No variable expansion.
echo '-------------------------------------'
echo 'Regular expression: [0-9]+\.[0-9]+'

# when you want to use variable expansion, command substitution... -> use double quotes.

# 3.2 Demonstrate that double quotes -> variable expansion, command substitution, etc.
echo "-------------------------------------"
echo "User: $USER, Home: $HOME, PID: $$"
echo "Current time: $(date)"

# 4. Notice when using no quotes.
# Risk when using no quotes: word splitting and glob expansion can occur, leading to unexpected behavior.
echo "-------------------------------------"

# 4.1 Demonstrate that no quotes -> word splitting
name="John Doe"
echo $name #Output: John Doe (Word splitting occurs, treated as two separate arguments)

# This can lead to unexpected behavior when passing variables as arguments to commands. For example:
# process_name $name #Output: process_name John Doe (Two separate arguments passed to the command)
# process_name "$name" #Output: process_name "John Doe" (Single argument passed to the command) (This is the correct way to pass variables as arguments to commands.)

# 4.2 Demonstrate that no quotes -> glob expansion
pattern="*.txt"
rm $pattern #Output: rm file1.txt file2.txt (All .txt files in the current directory are deleted) (This is dangerous, as it can lead to accidental deletion of files.)

rm "$pattern" #Output: rm "*.txt" (No glob expansion occurs, only the literal string "*.txt" is passed to the command) (This is the correct way to pass variables as arguments to commands when you want to avoid glob expansion.)