#!/bin/bash

# Part1:
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

# Remove the optión while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

# Check to see if the user provided any diferent arguments. If they did, display the usage information and exit with a status of 1.
if [[ "${#}" -gt 0 ]]
then
  usage
fi

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

# Part2:
# Bonus1: Learn about 'arithmetic expansion' in bash.
# Arithmetic expansion allows you to perform arithmetic operations in bash. The syntax for arithmetic expansion is $(( expression )). 
# e.g. $(( 2 + 2 )) will return 4.
# e.g. $(( 2 * 2 )) will return 4.
# e.g. $(( 2 / 2 )) will return 1.
# e.g. $(( 2 - 2 )) will return 0.
# Note: Bash only supports integer arithmetic, so you cannot use floating point numbers in arithmetic expansion. If you want to use floating point numbers, you can use the 'bc' command.

# Note: You can also use variables in arithmetic expansion. e.g. a=2; b=2; echo $(( a + b )) will return 4. the variables used in arithmetic expansion don't need to use the '$' sign to reference them. 

# Bonus2: Learn about 'bc' basic calculator command in bash.
# bc is might not be installed by default
# bc -h to see the help message.
# bc -l to turn on the math libraries with the -l option => floating point math 
# bc read from standard input and write to standard output. You can use the 'echo' command to pass a string to bc. e.g echo '6 / 4' | bc -l => 1.50000000000000000000

# Bonus3: You can use 'awk' command to perform arithmetic operations in bash. awk is a powerful text processing tool that can be used to perform arithmetic operations. The syntax for awk is awk 'BEGIN { print expression }'. e.g. awk 'BEGIN { print 2 + 2 }' will return 4.

# Bonus4: Learn about 'modulo' operator in bash.
# The modulo operator is represented by the '%' symbol. It returns the remainder of a division operation. e.g. $(( 5 % 2 )) will return 1 because 5 divided by 2 is 2 with a remainder of 1. 

# Bonus5: Learn how to change the value of a variable directly in bash.
# e.g. NUM='1'; (( NUM++ )) => NUM will be 2.
# You can also use --, +=, -=, *=, /=, %= operators to change the value of a variable directly in bash.

# Bonus6: Learn about 'let' command in bash. 
# The 'let' command is used to perform arithmetic operations in bash. 
# Syntax: let expression
#. e.g. let NUM = '2 + 2' will set the value of NUM to 4.

# Bonus7: Learn about 'expr' command in bash.
# The 'expr' command is used to evaluate expressions in bash.
# Syntax: expr expression
# The 'expr' command will process the expression given to it and return the result to standard output. 
#e.g. expr 2 + 2 will return 4.
#e.g. NUM=$(expr 2 + 3) will set the value of NUM to 5.

# Bonus8: 'getopts' does not change positional parameters, so you can use the positional parameters after the while loop to process the remaining arguments. in case, you want to process the remaining arguments, example you want to process the file names that are passed to your script, you can use the positional parameters after the while loop to process the remaining arguments. You can use the 'shift' command to shift the positional parameters to the left, so that you can access the remaining arguments. e.g. shift $(( OPTIND - 1 )) will shift the positional parameters to the left by the number of options that were processed by getopts. After this command, you can access the remaining arguments using $1, $2, $3, etc.
# OPTIND is a shell variable that is set by getopts to the index of the next argument to be processed. It is initialized to 1 before the first call to getopts, and it is incremented by 1 each time getopts processes an option. After all options have been processed, OPTIND will be set to the index of the first non-option argument.
# e.g ./script -a -b -c file1 file2 file3
# After the while loop, you can use shift $(( OPTIND - 1 )) OPTIND in case will be 4, so shift $(( OPTIND - 1 )) will shift the positional parameters to the left by 3, so that you can access the remaining arguments using $1, $2, $3, etc. After this command, $1 will be file1, $2 will be file2, and $3 will be file3.
# example: rm -f file1 file2 file3
