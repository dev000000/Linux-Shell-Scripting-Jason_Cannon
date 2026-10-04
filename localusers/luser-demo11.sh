#!/bin/bash

# Bonus1: Learn how to process command line options using the shell built-in 'getopts' command.
# If you want your shell script to behave like other Linux executables, you can allow user specify options that change the behavior of the script.
# Why use getopts instead of using if statements / case statements to process command line options?
# 1. getopts is a built-in command in bash that is used to parse command
# 2. if/case statements should only be used to process single command line options , if you want to process multiple command line options, handle combined options like -ab, -ba, -a -b.... if/case statment become very hard to manage, so you need to use getopts.

# Bonus2: Learn about 'getopts' command in bash.
# Note: recommend using shell built-in whenever possible because it makes your script more portable
# Syntax: getopts optstring name [args]
# opstring: There are the options that your script is going to recognize and accept. This is a series of letter that are going to be your options. If you wanna make an option mandatory, you can add a colon after the letter. 
# name: This is the name of the variable that is going to hold the option that is being processed.
# you don't know how many options the user is going to pass to your script, so you need to use a while loop to process all the options that the user is going to pass to your script.
# getopts wll return 0 as long as it finds an option to process, otherwise it returns one. which will cause the while loop to exit.

# This script generates a random password.
# This user can set the password length with -l and add a special character with -s.
# Verbose mode can be enabled with -v.

# The function 'usage' will display the usage information for the script and exit with a status of 1. The function is called when the user provides an invalid option or when the user provides the -h option. The function is modeled after 'man' pages, which is a common way to display usage information for command line programs.
usage () {
  echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
  echo 'Generate a random password.'
  echo '-l LENGTH Specify the password length.'
  echo '-s        Append a special character to the password.'
  echo '-v        Increase verbosity.'
  exit 1
}

# The function 'log' will display a message if the global variable 'VERBOSE' is set to 'true'. The block of code will be used many time in the script, so it is a good idea to put it in a function.
log() {
  local MESSAGE="${@}"
  if [[ "${VERBOSE}" = 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}
# Set a default password length
LENGTH=48

while getopts vl:s OPTION 
do
  case ${OPTION} in
    v)
      VERBOSE='true'
      log 'Verbose mode on.'
      ;;
    l)
      LENGTH="${OPTARG}" # When the option require argument, this argument is stored in the shell variable 'OPTARG'. You can use this variable to get the value of the option argument.
      ;;
    s)
      USE_SPECIAL_CHARACTER='true'
      ;;
    ?) # using question mark to catch all cases that are not defined in the case statement. This is a good practice to catch all the invalid options.
      usage
      ;;
  esac
done

log 'Generating a password.'

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Append a special character if requested to do so.
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
  log 'Selecting a random special character.'
  SPECIAL_CHARACTER=$(echo '!@#$%^&*()-+=' | fold -w1 | shuf | head -c1)
  PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done.'
log 'Here is the password:'

# Display the password.
echo "${PASSWORD}"

exit 0





