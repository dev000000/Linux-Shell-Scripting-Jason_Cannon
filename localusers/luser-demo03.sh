#!/bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is the vagrant user or not.

# 1.Display the UID
echo "Your UID is ${UID}"
echo "-------------------------------------"
# 2.Only display if the UID does NOT match 1000.
# In here, we using principles DRY (Don't Repeat Yourself) to avoid repeating the same code multiple times.
# If you work with long scripts or programs, you may want to use variables to store values that you will use multiple times. This way, if you need to change the value, you only need to change it in one place.
UID_TO_TEST_FOR='1000'
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
  echo "Your UID does not match ${UID_TO_TEST_FOR}."
  exit 1 # In here, i don't want to continue the script if the UID not match 1000, so I will stop the execution of the script with exit command.
fi
echo "--------------------------------------"

# Bonus1: You can use 'exit' command to stop the execution of the script.
# Syntax: exit [n] , n is the exit status of the script. 
# n = zero (0) means success
# n = non-zero (1-255) means failure

# Demonstration: 'useradd' command to create a new user. when using man useradd to learn about the command, you will see:
# EXIT VALUES
#  The useradd command exits with the following values:
#  0 success
#  1 can't update password file
#  2 invalid command syntax
#  3 invalid argument to option
#  4 UID already in use (and no -o)
#  6 specified group doesn't exist
#  9 username already in use
#  10 can't update group file
#  12 can't create home directory
#  14 can't update SELinux user mapping
# -> this means that if the command is not successful, you can check the exit status of the command to see what went wrong. After that, you can determine what wrong and fix it. This is a good practice to follow when writing scripts, as it will help you to debug your scripts and find out what went wrong.

# Bonus2: You can learn about some other operators for arithmetic comparison in bash, such as:
# -eq: equal to
# -ne: not equal to
# -lt: less than
# -le: less than or equal to
# -gt: greater than
# -ge: greater than or equal to
# => Learn more about test command by using 'man test' command.

# 3.Display the username.
USER_NAME=$(id -un)
# 4.Test if the command succeeded.
# Bash has very useful special variable called $? (dollar sign followed by a question mark) that holds the exit status of the last command executed. You can use this variable to check if the last command was successful or not. If the exit status is 0, it means the command was successful. If the exit status is non-zero, it means the command failed.
if [[ "${?}" -ne 0 ]]
then
  echo 'The id command did not execute successfully.'
  exit 1
fi
echo "Your username is ${USER_NAME}"
echo "-------------------------------------"
# 5.You can use a string test conditional.
# Equal sign can either be an assignment operator or a comparison operator depending on the context.
USER_NAME_TO_TEST_FOR='vagrant' # In this case, equal sign is a comparison operator, 
if [[ "${USER_NAME}" = "${USER_NAME_TO_TEST_FOR}" ]] # In this case, equal sign is a comparison operator
then
  echo "Your username matches ${USER_NAME_TO_TEST_FOR}."
fi
echo "-------------------------------------"
# Bonus3: You can use '==' double equal sign for string comparison, but a little bit different from single equal sign. The double equal sign is used for pattern matching, while the single equal sign is used for string comparison. In this case, we are using single equal sign for string comparison, so it is more appropriate to use single equal sign.

# 6.Test for != (not equal) for the string.
if [[ "${USER_NAME}" != "${USER_NAME_TO_TEST_FOR}" ]] 
then
  echo "Your username does not match ${USER_NAME_TO_TEST_FOR}."
  exit 1
fi
echo "-------------------------------------"


exit 0 # when the script is executed successfully at the end, we can use exit 0 to indicate that the script executed successfully. This is a good practice to follow when writing scripts, as it will help you to debug your scripts and find out what went wrong.

# If you don't specify an exit status or exit code, the exit status of the most recently executed command will be used as the exit status of the script. 
