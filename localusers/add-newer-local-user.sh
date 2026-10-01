#!/bin/bash
# This script create an account on the local system. (Script for documents/Exercise-04-Creating-Local-Users-03.pdf)
# You must supply a username as an argument to the script.
# Optionally, you can also provide a comment for the account as an argument.
# A password will be automatically generated for the account.
# The username, password, and host for the account will be displayed.
# All message associated with event (check)

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run with sudo or as root.' >&2
  exit 1
fi

# Check username is supplied as an argument.
if [[ "${#}" -gt 0 ]]
then
  USER_NAME="${1}"
  shift
  COMMENT="${@}" # All the rest of the parameters are for the account comment.
  PASSWORD=$(date +%s%N | sha256sum | head -c48)
else
  echo "Usage: ${0} USER_NAME [COMMENT]" >&2
  echo "Create an account on the local system with the name of USER_NAME and a comments field of COMMENT." >&2
  exit 1
fi

# Create the user with the specified information.
if [[ "${COMMENT}" == "" ]]
then
  useradd -m "${USER_NAME}" &> /dev/null
else
  useradd -c "${COMMENT}" -m "${USER_NAME}" &> /dev/null
fi

# Check to see if the useradd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "->Process of create user is error" >&2
  exit 1
fi

# Set the password.
echo "${PASSWORD}" | passwd --stdin "${USER_NAME}" &> /dev/null

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]
then
  echo "->Process of set password is error" >&2
  exit 1
fi

# Force password change on first login.
passwd -e "${USER_NAME}" &> /dev/null
if [[ "${?}" -ne 0 ]]
then
  echo "->Process of expire password is error" >&2
  exit 1
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
