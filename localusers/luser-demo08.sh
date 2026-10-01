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


# Bonus6: Learn about File Descriptor (FD).
# File Descriptor (FD) is a number that represents an open file.
# By default, every new process starts with three open file descriptors:
# FD0 - STDIN
# FD1 - STDOUT
# FD2 - STDERR
# You maybe thinking that default standard input comes from the keyboard, standart output and error display on the screen. These not a file , but they are represented by file descriptors. Why is that ? Well, in Linux everything is a file. So, the keyboard, screen, and even network connections are represented as files. 

# Bonus7: Distinguish between explicit and implicit redirection.
# Implicit redirection is when you use the default file descriptors (STDIN, STDOUT, STDERR) without specifying them. For example, COMMAND > FILE (don't specify FD to the command, if you don't specify, it will use the default FD1 for STDOUT)

# Explicit redirection is when you specify the file descriptor to redirect. For example, COMMAND 1> FILE (specify FD1 to the command)

# Explicit redirection: {FD}{operator} , FD: 0,1,2 ; operator: >,>>,<,<<,>&,<&,<>
# Implicit redirection: {operator} , operator: >,>>,<,<<,>&,<&,<>

# Note: No space between FD and operator. If you put a space, it will be treated as a command argument, not a redirection operator.

# Some example and explaination of this example:
# 1. COMMAND > FILE: redirect STDOUT to FILE, overwriting the file. 
# 2. COMMAND >> FILE: redirect STDOUT to FILE, appending to the file.
# 3. COMMAND 2> FILE: redirect STDERR to FILE, overwriting the file.
# 4. COMMAND 2>> FILE: redirect STDERR to FILE, appending to the
# 5. COMMAND > FILE.OUT 2> FILE.ERR: redirect STDOUT to FILE.OUT and STDERR to FILE.ERR, overwriting both files.
# 6. COMMAND >> FILE.OUT 2>> FILE.ERR: redirect STDOUT to FILE.OUT and STDERR to FILE.ERR, appending to both files.

# Bonus8: Learn about how to redirect both STDOUT and STDERR to the same place.
# Older syntax: COMMAND > FILE 2>&1 ( normally after redirect operator, you can specify the file name, but in this case, you can using & (ampersand symbol) with the file descriptor number to indicate that you want to redirect to the same place as another file descriptor. In this case, you are redirecting STDERR (FD2) to the same place as STDOUT (FD1).)

# Newer syntax: COMMAND &> FILE ( this is a shorthand for the older syntax. It redirects both STDOUT and STDERR to the same place. )

# Bonus9: Learn about pipe standard output and standard error to another command.
# Default behavior: COMMAND | COMMAND ( this is a pipe, it takes the STDOUT of the first command and feeds it as STDIN to the second command. STDERR is not affected by the pipe, it will still be displayed on the screen.)

# Older suntax: COMMAND 2>&1 | COMMAND ( this is a pipe, it takes the STDOUT of the first command and feeds it as STDIN to the second command. STDERR is redirected to the same place as STDOUT, so it will also be fed as STDIN to the second command.)

# Newer syntax: COMMAND |& COMMAND ( this is a shorthand for the older syntax. It takes both STDOUT and STDERR of the first command and feeds it as STDIN to the second command.)

# 5. Redirect STDIN to a program, using FD 0.
read LINE 0< ${FILE}
echo 
echo "LINE contains: ${LINE}"

# 6. Redirect STDOUT to a file using FD 1, overwriting the file.
head -n3 /etc/passwd 1> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# 7. Redirect STDOUT and STDERR through a pipe.
echo 
head -n3 /etc/passwd /fakefile |& cat -n

# Bonus10: Learn about standard output to the standard error.
# You can redirect STDOUT to STDERR using the following syntax: COMMAND 1>&2
# this is useful when you want to send the output of a command to the error stream, for example, when you want to log an error message.
# e.g:
# head -n3 /etc/passwd /fakefile
# if [[ $? -ne 0 ]]; then
#    echo "Error: failed to read /etc/passwd or /fakefile" 1>&2
#    exit 1
# fi
# You want to save the error message to a error log file, you can trace the reason of the error when error occurs. output file will only contain the real output.

# 8. Send output to STDERR
echo "This is STDERR!" >&2

# Bonus11: Learn about 'null' device ( bit bucket).
# The null device is a special file that throws away whatever is sent to it.
# If you don't want to see the output on the screen, and you don't want to save it to a file. you can redirect it to the null device ( /dev/null)

# 9. Discard STDOUT.
echo
echo "Discarding STDOUT:"
head -n3 /etc/passwd /fakefile > /dev/null

# 10. Discard STDERR.
echo
echo "Discarding STDERR:"
head -n3 /etc/passwd /fakefile 2> /dev/null

# 11. Discard both STDOUT and STDERR.
echo
echo "Discarding both STDOUT and STDERR:"
head -n3 /etc/passwd /fakefile &> /dev/null

# 12. Clean up
rm ${FILE} &> /dev/null
