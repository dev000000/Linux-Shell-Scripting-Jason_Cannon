#!/bin/bash

# This script demonstrates the case statement.

# This code block if else is doing is taking an action based on the value stored in ${1}.
# if [[ "${1}" = 'start' ]]
# then
#   echo "Starting..."
# elif [[ "${1}" = 'stop' ]]
# then
#   echo "Stopping..."
# elif [[ "${1}" = 'status' ]]
# then
#   echo "Status:"
# else
#   echo "Supply a valid option." >&2
#   exit 1
# fi

# This case statement is doing the same thing as the if else block above, but it is easier to read and understand.
# If you are using a case statement instead of an if else block, you don't need repeat the variable name in each condition. 

# Syntax of a case statement: case word in [ [(] pattern [ | pattern] ... ) command-list ;; ]... esac
# Definition: A case command first expands word, and tries to match it against each pattern in turn, using the same matching rules as for 'pathname expansion'.

# Note: The case statement is run top to bottom, and the first pattern that matches is the one that is executed. Because of this, you should put the most specific patterns at the top of the case statement, and the most general patterns at the bottom.

# You can use the '|' (pipe) character to separate multiple patterns that should be treated the same way. For example, you could use 'status|state' to match both 'status' and 'state', and execute the same command for both.

# Let's learn about 'pathname expansion' 
# * (asterisk) matches any string, including the null string.
# ? (question mark) matches any single character.
# [ ] (brackets) matches any one of the enclosed characters. A pair of brackets can also be used to specify a range of characters, using a hyphen as in [a-z] or [0-9].

# case "${1}" in
#   start)
#     echo "Starting..."
#     ;;
#   stop)
#     echo "Stopping..."
#     ;;
#   status|state|--status|--state)
#     echo "Status:"
#     ;;
#   *)
#     echo "Supply a valid option." >&2
#     exit 1
#     ;;
# esac

# Learn about spacing and style when you are writing the code.
# Spacing: You can indent each section by two spaces, four spaces, a tab or no indent. It is your choice, but you should be consistent throughout your script.
# Style: If the command list is only one line, you can put it on the same line as the pattern, but if it is more than one line, you should put it on the next line and indent it. You should also put the ';;' on its own line after the command list. ( the example below is the same as the example above, but it is formatted differently. )

case "${1}" in
  start) echo "Starting..." ;;
  stop) echo "Stopping..." ;;
  status|state|--status|--state) echo "Status:" ;;
  *)
    echo "Supply a valid option." >&2
    exit 1
    ;;
esac