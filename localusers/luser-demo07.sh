#!/bin/bash

# Demonstrate the use of shift and while loops.

# 1.Display the first three parameters.
echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"
echo # this is just a blank line for readability

# When the script is called, the first three parameters are displayed. but you cannot assume that the user will always provide three parameters. So, we will use a while loop to display all the parameters provided by the user.

# Bonus1: Learn about 'while' loops
# Syntax: WHILE COMMANDS; do COMMANDS; done
# Definition: Expand and execute COMMANDS as long as the final command in the 'while' COMMANDS has an exit status of zero.
# Exit status: Returns the status of the last command executed.

# Bonus2: Learn about 'true' command
# Syntax: true
# Definition: The 'true' command is a command that always returns a successful exit status (0). 

# Bonus3: Learn about 'sleep' command
# Syntax: sleep NUMBER[SUFFIX] ( SUFFIX can be 's' for seconds, 'm' for minutes, 'h' for hours, or 'd' for days)
# Definition: The 'sleep' command is used to delay for a specified amount of time. 

# Bonus4: Learn about 'shift' command
# Syntax: shift [n]
# Definition: The 'shift' command is used to shift the positional parameters to the left.
# Explaination: If n is specified, it shifts the positional parameters n times. If n is not specified, it shifts the positional parameters once. After shifting, the value of $1 becomes the value of $2, $2 becomes the value of $3, and so on. The last parameter is lost.

# 2. Loop through all the positional parameters.
while [[ "${#}" -gt 0 ]]
do
  echo "Number of parameters: ${#}"
  echo "Parameter 1: ${1}"
  echo "Parameter 2: ${2}"
  echo "Parameter 3: ${3}"
  shift
  echo
done
