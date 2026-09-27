#!/bin/bash

# This script generates a random password for each user specified on the command line.

# 1.Display what the user typed on the command line
echo "You executed this command: ${0}"

# Bonus1: Distinquish between 'parameter' and 'argument' in bash
# Parameter: is a variable that is being used inside the shell script.
# Argument: is a data passed into the shell script.
# Flow of data: User types command and passes arguments -> Shell script receives the arguments and assigns them to parameters -> Shell script uses the parameters to perform actions.

# Bonus2: Learn about some special parameters in bash
# $0: Stores the name of the script being executed.
# $1, $2, $3, ...: Stores the first, second, third, ... argument passed to the script.
# $#: Stores the number of arguments passed to the script
# $@: Stores all the arguments passed to the script as a single string.
# $*: Stores all the arguments passed to the script as a single string, but with each argument separated by the first character of the IFS variable (default is space). 

# The difference between $@ and $* is that $@ treats each argument as a separate word, while $* treats all arguments as a single word. This can affect how the arguments are processed by the script.
# e.g. If the script is executed with the command: ./script.sh arg1 arg2 "arg3 with spaces"
# $@ will expand to: arg1 arg2 arg3 with spaces
# $* will expand to: arg1 arg2 arg3 with spaces

# Bonus3: Learn about '$PATH' variable in bash
# Definition: is a colon-sperated list of directories in which the shell looks for commands.
# The order executed when bash looks for a keyword when you type it in the terminal is:
# 1. Check if the keyword is a function or not ?
# 2. Check if the keyword is a built-in command or not ?
# 3. Check the keyword in the directories listed in the $PATH variable, in the order they are listed. (the first match found is executed)
# 4. If no match is found, bash will return an error message: "command not found".

# Bonus4: Learn about 'which' command in bash
# The 'which' command is used to locate the executable file associated with a given command by searching the directories listed in the $PATH variable. It returns the path of the executable file if found, or nothing if not found.
# e.g. 'which ls' command will display -> /bin/ls

# Note: bash using hash table to remember the location of executables that have been run before, so if you run a command that has been run before, bash will use the cached location instead of searching the $PATH variable again. This can speed up command execution, but it can also cause problems if the executable has been moved or deleted since it was last run.
# When this issue occurs, you can use the 'hash' command to clear the hash table or to remove a specific command from the hash table. The syntax is:
# hash -r: Clear the entire hash table.
# hash -d command: Remove the specified command from the hash table.

# Bonus5: Learn about 'basename' command in bash
# The 'basename' command is used to extract the filename from a given path. It removes the directory path and returns only the filename. The syntax is:
# basename [path] [suffix]
# e.g. 'basename /home/user/file.txt' command will display -> file.txt

# Bonus6: Learn about 'dirname' command in bash
# The 'dirname' command is used to extract the directory path from a given path. It
# removes the filename and returns only the directory path. The syntax is:
# dirname [path]
# e.g. 'dirname /home/user/file.txt' command will display -> /home/user

# 2. Display the path and filename of the script.
echo "You used $(dirname ${0}) as the path to the $(basename ${0}) script."

# 3. Tell them how many arguments they passed in.
# (Inside the script they are parameters, outside they are arguments.)
NUMBER_OF_PARAMETERS="${#}"
echo "You supplied ${NUMBER_OF_PARAMETERS} argument(s) on the command line."

# 4. Make sure they at least supply one argument.
if [[ "${NUMBER_OF_PARAMETERS}" -eq 0 ]]
then
  echo "Usage: ${0} USER [USER]..."
  exit 1
fi

# Bonus7: In bash, arguments are separated by spaces, but quotes can group multiple words into a single argument. For example, if you run the command: ./script.sh "arg1 with spaces" arg2, the script will receive two arguments: "arg1 with spaces" and "arg2". The quotes are not part of the argument, they are just used to group the words together.

# Bonus8: Learn about 'for loop' in bash
# The 'for loop' is used to iterate over a list of items and execute a block of code for each item in the list. The syntax is:
# for variable in list
# do
#   commands
# done
# e.g. 'for i in 1 2 3; do echo $i; done' command will display:
# 1
# 2
# 3
# Explain the 'for loop':
# for NAME [in WORDS ...]; do COMMANDS; done
# NAME: is a variable that will take on the value of each item in the list.
# WORDS: is a list of items that the loop will iterate over.
# COMMANDS: is a block of code that will be executed for each item in the list.
# Flow of for loop:
# 1. The loop starts by assigning the first item in the list to the variable NAME.
# 2. The commands in the loop are executed.
# 3. The loop then assigns the next item in the list to the variable NAME and repeats the process until all items in the list have been processed.

# 5. Generate and display a password for each parameter.
for USER_NAME in "${@}"
do
  PASSWORD=$(date +%s%N | sha256sum | head -c48)
  echo "The password for user ${USER_NAME} is ${PASSWORD}"
done
