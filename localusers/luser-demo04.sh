#!/bin/bash

# This script create an account on the local system.
# You will be prompted for the account name and password.

# Two ways to get the external input from the user: 
# using 'read' command (covered in this script)
# passing parameters to the scripts (this will be covered in the next script)

# Bonus1: Learn about 'read' command
# The 'read' command will read a line from the standard input and split it into fields.
# Syntax: read [options] [name...] 
# In the syntax above, 'name' is the name of the variable that will hold the input from the user.
# You can use multiple variables to hold the input [name...].
# Note that the user can enter input containing spaces (e.g. "John Doe").
# If you use one variable, it will hold the entire input (e.g. "John Doe").
# If you use multiple variables, the input will be split into fields:
# the first variable holds the first word, the second variable holds the second word, and so on.
# The last variable holds all remaining words.

# read has a 'p' option that allows you to specify a prompt to display before reading the input. This is useful for prompting the user for input.
# e.g. read -p "Enter your name: " NAME


# By default, there are three default type of input and output:
# standard input (stdin) - the keyboard (default)
# standard output (stdout) - the terminal (default)
# standard error (stderr) - the terminal (default)
# 1.Ask for the user name.
read -p 'Enter the username to create: ' USER_NAME
# 2.Ask for the real name.
read -p 'Enter the name of the person who this account is for: ' COMMENT
# 3.Ask for the password.
read -p 'Enter the password for the account: ' PASSWORD


# Bonus2: Learn about convention for usernames
# By convention, usernames should be:
# all lowercase
# <= 8 characters
# contain letters and numbers only (no special characters)
# -> Linux is case-sensitive, so 'John' and 'john' are different usernames.

# Bonus3: Learn about 'useradd' command to create a new user.
# The '-c | --comment' option generally used to specify short description of the login, and is currently used as the field for the user's full name.
# The '-m | --create-home' option is used to create the user's home directory if it does not exist. The files and directories in the skeletion directory (which can be defined with the -k option) will be copied to the home directory.
# By default, if this option is not specified and CREATE_HOME (specified in the /etc/login.defs file) is not enabled, no home directory are created.
# If you want to create home directory for the user certainly, you should use -m option. Because some Linux distributions have CREATE_HOME enabled by default, while some do not. So, to be sure that the home directory is created, you should use -m option.
# Skeleton directory is a directory that contains files and directories that will be copied to the new user's home directory when it is created. The default skeleton directory is /etc/skel, but you can specify a different skeleton directory with the -k option.

# 4.Create the user.
useradd -c "${COMMENT}" -m "${USER_NAME}"

# Bonus4: Learn about 'passwd' command to change the password of a user.
# If you typing 'passwd' command in the terminal, it will prompt you to enter the new password for the current user. If you want to change the password for another user, you can specify the username as an argument to the 'passwd' command. e.g. passwd USER_NAME
# Default, 'passwd' is interactive command, which means it will prompt you to enter the new password and confirm it. If you want to automate the process of changing the password, you can use '-stdin' option to read the password from standard input. e.g. echo "PASSWORD" | passwd --stdin USER_NAME
# By convention, the password must be changed on first login, because the initial password is usually temporary and is set by the administrator. The user should change the password to something only they know. This is a security measure to prevent unauthorized access to the account. You can use '-e' option to expire the password, which will force the user to change their password on first login. e.g. passwd -e USER_NAME

# 5.Set the password for the user.
echo "${PASSWORD}" | passwd --stdin "${USER_NAME}"

# 6.Force the user to change their password on first login.
passwd -e "${USER_NAME}"
