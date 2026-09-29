#!/bin/bash

# This script demonstrates I/O redirection.

# Bonus1: Learn about three types of I/O.
# Standard Input (STDIN): The default is come from the keyboard.
# Standard Output (STDOUT): The default is to display on the screen.
# Standard Error (STDERR): The default is to display on the screen.

# 1.Redirect STDOUT to a file.
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}
# Bonus2: Learn about '>' greater than sign.
# This sign is used to redirect STDOUT to a file. If the file does not exist, it will be created. If the file exists, it will be overwritten.

# Note: the redirection operation is based on permission. If the user does not have permission to write to the file, the redirection will fail.

# Bonus3: Learn about '<' less than sign.
# This sign is used to redirect STDIN from a file.

# 2.Redirect STDIN to a program.
read LINE < ${FILE} # read command reads a line from standard input and assigns it to a variable. In this case, the standard input is redirected from the file ${FILE}. 
echo "LINE contains: ${LINE}" 

# Bonus4: Distinguish between input redirection ( < ) and pipe ( | ).
# Input redirection takes data from a file and feeds it to a command. ( if you want to read data from a file, you can use input redirection.)
# Pipe takes the output of one command and feeds it as input to another command. ( if you want to use the output of one command as input to another command, you can use a pipe.)

# Bonus5: Learn about '>>' double greater than sign.
# This sign is used to redirect STDOUT to a file. If the file does not exist, it will be created. If the file exists, it will be appended to. ( not the same as '>' which overwrites the file.)

# 3.Redirect STDOUT to a file, overwriting the file.
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# 4.Redirect STDOUT to a file, appending to the file.
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}
