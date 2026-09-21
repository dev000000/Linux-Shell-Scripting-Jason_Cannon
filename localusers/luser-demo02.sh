#!/bin/bash

# Display the UID and username of the user executing this script.
# Display if the user is the root user or not.

# 1.Display the UID
echo "1.Your UID is ${UID}" # Output: this UID is 1000 UID is a special variable in bash that holds the user ID of the current user.

echo "-------------------------------------"
UID=1004 # UID is a special variable in bash that holds the user ID of the current user. It is read-only and cannot be changed. ( read-only variable, cannot be changed)
echo "2.Your UID is ${UID}" # Output: this UID also be 1000 , not changed to 1004.

# Bonus1: Distinguish between UID and EUID.
# UID is the real user ID
# EUID is the effective user ID, which is used for permission checks. 

# In most cases, they are the same, but they can differ in certain scenarios, such as when using sudo.
# Eg: When you run a command with sudo, the EUID will be 0 (root), while the UID will remain your original user ID. Because of this, you can run commands without needing to be root, but still have the permissions of root for that command. This is useful for security and access control.

# Bonus2: Learn about 'id' command to display the UID and EUID of the current user.
# Option:
#       -n, --name
#              print a name instead of a number, for -ugG
#       -u, --user
#              print only the effective user ID

# Demonstration:
echo "-------------------------------------"
echo "3.Output of 'id' command: $(id)" # Output: uid=1000(vagrant) gid=1000(vagrant) groups=1000(vagrant)
echo "4.Output of 'id -u' command: $(id -u)" # Output: 1000
echo "5.Output of 'id -u -n' command: $(id -u -n)" # Output: vagrant
echo "6.Output of 'id -n -u' command: $(id -n -u)" # Output: vagrant (The order of the options does not matter, as long as they are all present.)
echo "7.Output of 'id -un' command: $(id -un)" # Output: vagrant (You can also combine the options into a single option, don't need to use -n, -u, -g, -G, etc. separately.)

# Bonus3: Learn about 'whoami' command to display the username of the current user.
# Demonstration:
echo "-------------------------------------"
echo "8.Output of 'whoami' command: $(whoami)" # Output: vagrant (This command is equivalent to 'id -un', but it is more commonly used and easier to remember.)

# 2.Display the username
USERNAME1=$(id -un) # assign output of 'id -un' command to variable USERNAME (command substitution)
USERNAME2=`id -un` # assign output of 'id -un' command to variable USERNAME (command substitution, old style)
echo "-------------------------------------"
echo "9.Your username is ${USERNAME1}" # Output: Your username is vagrant
echo "10.Your username is ${USERNAME2}" # Output: Your username is vagrant

# 3.Display if the user is the root user or not.
# The syntax of the if statement is:
# if [[ condition ]] 
# then
#   commands
# else
#   commands
# fi 
echo "-------------------------------------"
echo "13.Using double square brackets [[ ]]"
if [[ "${UID}" -eq 0 ]]
then
  echo 'You are root.'
else
  echo 'You are not root.'
fi
echo "-------------------------------------"
echo "14.Using single square brackets [ ]"
if [ "${UID}" -eq 0 ]
then
  echo 'You are root.'
else
  echo 'You are not root.'
fi
echo "-------------------------------------"
echo "15.Using test command"
if test "${UID}" -eq 0
then
  echo 'You are root.'
else
  echo 'You are not root.'
fi
