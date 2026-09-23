#!/bin/bash

# This script create an account on the local system. (Script for documents/Exercise-02-Creating-Local-Users-01.pdf)
# It will prompt the user for the username, real name, and password.
# It will then create the user with the specified information.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run with sudo or as root.'
  exit 1
fi

# Get the username (login).
read -p 'Enter the username to create: ' USER_NAME
# Get the real name (contents for the description field).
read -p 'Enter the name of the person or application that will be using this account: ' COMMENT
# Get the password.
read -p 'Enter the password to use for the account: ' PASSWORD

# Create the user with the password.
useradd -c "${COMMENT}" -m "${USER_NAME}"

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "->Process of create user is error"
  exit 1
else 
  echo "->Process of create user is successful"
fi

# Set the password.
echo "${PASSWORD}" | passwd --stdin "${USER_NAME}"

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "->Process of set password is error"
  exit 1
else
  echo "->Process of set password is successful"
fi

# Force password change on first login.
passwd -e "${USER_NAME}" 
if [[ "${?}" -ne 0 ]]
then
  echo "->Process of expire password is error"
  exit 1
else
  echo "->Process of expire password is successful"
fi

# Display the username, password, and the host where the user was created.
echo "username:"
echo "${USER_NAME}"
echo

echo "password:"
echo "${PASSWORD}"
echo

echo "host:"
echo "$(hostname)"

exit 0

