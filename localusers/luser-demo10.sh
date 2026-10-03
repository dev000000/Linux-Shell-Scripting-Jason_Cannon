#!/bin/bash

# Bonus1: Briefly learn about functions.
# Function is a group of commands that you call using a single name in the script.
# Function is also called 'little script' inside the main script.
# Reason to use function:
# 1. To avoid code duplication. ( DRY principle: Don't Repeat Yourself ) => write the code once and call it multiple times.
# Note: DRY >< WET (Write Everything Twice / We Enjoy Typing / Waste Everyone's Time) => write the code multiple times and call it multiple times.
# 2. To break up large tasks into a series of smaller tasks. => This makes easier to maintain 

# Bonus2: Learn about 'function'
# Syntax: function name { COMMANDS;} or name() { COMMANDS; }
# How to call a function: name or name arg1 arg2 arg3
# Note: the script will read top to bottom, so you need to define the function before you call it. If you call the function before it is defined, you will get an error message.


# 1. Define a function called 'log' that will display a message when it is called.

# Method 1: Define a function without using the 'function' keyword.
# log() {
#   echo 'You called the log function!'
# }

# Method 2: Define a function using the 'function' keyword.
function log {
  echo 'You called the log function!'
}

log

echo "-------------------------------------"

# 2. Define a function called 'log2' that will display a screen whatever is passed to it

function log2 {
  local MESSAGE="${@}"
  echo "${MESSAGE}"
}

log2 "Hello"
log2 "This is fun!"

# Bonus3: Learn about type of variables in bash.
# 1. Global variable (default) is a variable that is available anywhere in the script. It is available inside and outside of functions.
# 2. Local variable is a variable that is only available inside the function. It is not available outside the function.
# Note: If you define a global variable inside a function, it is not available until the function is called. 
# Best practice is to use local variables inside functions to avoid variable name conflicts and to make the function more self-contained.

# Bonus4: Learn about positional parameters in functions.
# How to use positional parameters in functions is the same as how to use positional parameters in scripts. You can use $1, $2, $3, etc. to access the arguments passed to the function. You can also use "$@" to access all the arguments passed to the function as a single string.
# The only difference is that $0 is still the name of the script not the name of the function.

# 3. Define a function called 'log3' that only display the message passed to it if global variable 'VERBOSE' is set to 'true'. If 'VERBOSE' is set to 'true'.
echo "-------------------------------------"
log3 () {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

log3 "Hello" # The message will not be displayed because VERBOSE is not set to true yet.
VERBOSE='true'
log3 "This is fun!" # The message will be displayed because VERBOSE is set to true.

# Bonus5: Learn about 'readonly' variable in bash.
# A readonly variable is a variable that cannot be changed once it is set. You can use the 'readonly' command to make a variable readonly.
# Syntax: readonly VARIABLE_NAME = VALUE or VARIABLE_NAME = VALUE; readonly VARIABLE_NAME

# Bonus6: Learn about 'logger' command in bash.
# The logger command is used to make entries in the system log. It provides a shell command interface th the syslog(3) system log module.
# By default, CentOS or RHEL system logs are stored in /var/log/messages file.
# Syntax: logger [options] [message]
# Options:
# -t --tag: Mark every line to be logged with the specified tag.
# e.g: 
# logger 'Hello from the command line!'
# Jan 12 17:49:59 localusers vagrant: Hello from the command line!
# Format of the log entry:
# <date> <hostname> <tag>: <message> 
# if tag is not specified, the default tag is the name of the user who is running the command. In this case, the default tag is 'vagrant' because the command is run by the user 'vagrant'.

# Note: syslog can be configured to send messages off the server and to a centralized syslog location, that is a good security measure because someone were to have root access to one system, any logs that they generated are not only stored locally, where they could potenntially change them or delete them, but they're also stored on a remote system where hopefully, that person or that attacker hasn't broken into that system as well.

# 4. Define a function called 'log4' that will display a message and log it to the system log using the 'logger' command.

echo "-------------------------------------"

function log4 {
  # This function sends a message to syslog and to standard output if VERBOSE is true.
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

readonly VERBOSE='true'

log4 "Hello"
log4 "This is fun!" 

# 5. Define a function called 'backup_file' that will create a backup of a file passed to it as an argument.

backup_file() {
  # This function creates a backup of a file. Return non-zero status on error
  local FILE=${1}
  
  # Make sure the file exists.
  if [[ -f "${FILE}" ]]
  then
    local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log4 "Backing up ${FILE} to ${BACKUP_FILE}."
    # The exit status of the function will be the exit status of the cp command.
    cp -p ${FILE} ${BACKUP_FILE}
  else
    # The file does not exist, so return a non-zero exit status.
    return 1
  fi
}

backup_file "/etc/passwd"

# Make a decision based on the exit status of the function.
if [[ "${?}" -eq 0 ]]
then
  log4 "File backup succeeded!"
else
  log4 "File backup failed!"
  exit 1
fi

# Bonus7: Learn about life cycle of "/var/tmp" and "/tmp" directories in Linux.
# /var/tmp directory is reserved on reboot, so files in this directory will not be deleted when the system is rebooted.
# /tmp directory is not reserved on reboot, so files in this directory will be deleted when the system is rebooted.
# Why we use "/var/tmp" directory in the backup_file function is to ensure that the backup files are not deleted when the system is rebooted. This is important because we want to keep the backup files for a longer period of time, even if the system is rebooted.

# Bonus8: Learn about 'date +%F-%N' command in Linux.
# The 'date' command is used to display the current date and time.
# The '+%F' option is used to display the date in the format YYYY-MM-DD.
# The '-%N' option is used to display the nanoseconds of the current time.
# Why we use 'date +%F-%N' in the backup_file function is to create a unique backup file name that includes the current date and time down to the nanosecond. This ensures that each backup file has a unique name, even if multiple backups are created in quick succession.

# Bonus9: Learn about cp -p command in Linux.
# The 'cp' command is used to copy files and directories.
# The '-p' option is used to preserve the original file's attributes, such as the
# permissions, ownership, and timestamps.
# Why we use 'cp -p' in the backup_file function is to ensure that the backup file has the same attributes as the original file. This is important because we want to maintain the integrity of the original file's attributes in the backup file.

# Bonus10: Distinguish between 'return' and 'exit' commands in bash.
# The 'return' command is used to exit a function and return a value to the calling function or script.
# The 'exit' command is used to exit the entire script and return a value to the calling process. No matter where you are in the script, if you use 'exit', the script will terminate immediately. If you use 'return', the function will terminate and return control to the calling function or script.