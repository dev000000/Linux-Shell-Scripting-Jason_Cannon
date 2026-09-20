#!/bin/bash

# This script displays various information to the screen.

# 1.Display 'Hello'.
echo 'Hello'

# 2.Assign a value to a variable.
WORD='script'

# Valid variable name only contain ( letters, digits, underscores )
# Valid variable name start by letters or underscores 

# Valid:
# WORD
# WORD1
# _WORD

# Not Valid:
# _3WORD
# A-WORD
# E@MAIL

# 3.Display that value using the variable.
echo "$WORD"

# 4.Demonstrate that single quotes cause variablew to NOT get expanded.
echo '$WORD'

# 5.Combine the variable with hard-code text.
echo "This is a shell $WORD"

# 6.Display the contents of the variable using an alternative syntax.
echo "This is a shell ${WORD}"

# 7.Append text to the variable.
echo "${WORD}ing is fun!"

# 8.Show how NOT to append text to a variable. (This doesn't work:)
echo "$WORDing is fun!"

# 9.Create a new variable.
ENDING='ed'

# 10.Combine the two variables.
echo "This is ${WORD}${ENDING}"

# 11.Change the value stored in the ENDING variable. (Reassignment.)
ENDING='ing'
echo "${WORD}${ENDING} is fun!"

# 12.Reassign value to ENDING.
ENDING='s'
echo "You are going to write many ${WORD}${ENDING}"

