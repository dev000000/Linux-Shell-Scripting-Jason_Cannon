#!/bin/bash
# This script disables, deletes, and/or archives users on the local system. (Script for documents/Exercise-05-Deleting-Local-Users-04.pdf)

readonly ARCHIVE_DIR='/archives'

EXIT_STATUS=0

# Display the usage and exit.
usage() {
  echo "Usage: ${0} [-dra] USERNAME [USERNAME...]" >&2
  echo "Disable a local Linux account." >&2
  echo "Option:" >&2
  echo " -d   Deletes accounts instead of disabling them." >&2
  echo " -r   Removes the home directory associated with the account(s)." >&2
  echo " -a  Creates an archive of the home directory associated with the accounts(s) and stores the archive in the /archives directory. " >&2
  exit 1
 }

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run with sudo or as root.' >&2
  exit 1
fi

# Parse the options.
while getopts dra OPTION
do
  case ${OPTION} in
    d) DELETE_USER='true' ;;
    r) REMOVE_OPTION='-r' ;;
    a) ARCHIVE='true' ;;
    ?) usage ;;
  esac
done

# Remove the options while leaving the remaining arguments.
shift "$(( OPTIND - 1 ))"

# if the user doesn't supply at least one argument, give them help.
if [[ "${#}" -lt 1 ]]
then 
  usage
fi

# Loop through all the usernames supplied as arguments.
while [[ "${#}" -gt 0 ]]
do
  USER_NAME="${1}"
  shift 1
  echo "Processing user: ${USER_NAME}"
  # Make sure the UID of the account is at least 1000.
  USERID=$(id -u ${USER_NAME})
  if [[ "${USERID}" -lt 1000 ]]
  then
    echo "Refusing to remove the ${USER_NAME} account with UID ${USERID}." >&2
    EXIT_STATUS=1
    continue
  else
    # Create an archive if requested to do so.
    if [[ "${ARCHIVE}" = "true" ]]
    then
      # Make sure ARCHIVE_DIR directory exists.
      if [[ ! -d "${ARCHIVE_DIR}" ]]
      then
        echo "Creating ${ARCHIVE_DIR} directory."
        mkdir -p "${ARCHIVE_DIR}"
        if [[ "${?}" -ne 0 ]]
        then
          echo "The archive directory ${ARCHIVE_DIR} could not be created." >&2
          EXIT_STATUS=1
          continue
        fi
      fi
      # Archive the user's home directory and move it into the ARCHIVE_DIR.
      HOME_DIR="/home/${USER_NAME}"
      ARCHIVE_FILE="${ARCHIVE_DIR}/${USER_NAME}.tgz"
      if [[ -d "${HOME_DIR}" ]]
      then
        echo "Archiving ${HOME_DIR} to ${ARCHIVE_FILE}"
        tar -zcf "${ARCHIVE_FILE}" "${HOME_DIR}" &> /dev/null
        if [[ "${?}" -ne 0 ]]
        then
          echo "Could not create ${ARCHIVE_FILE}." >&2
          EXIT_STATUS=1
          continue
        fi
      else
        echo "${HOME_DIR} does not exist or is not a directory." >&2
        EXIT_STATUS=1
        continue
      fi
    fi

    if [[ "${DELETE_USER}" = "true" ]]
    then
      # Delete the user
      userdel ${REMOVE_OPTION} ${USER_NAME}

      # Check to see if the userdel command succeeded.
      # We don't want to tell the user that an account was deleted when it hasn't been.
      if [[ "${?}" -ne 0 ]]
      then
        echo "The account ${USER_NAME} was NOT deleted." >&2
        EXIT_STATUS=1
        continue
      fi
      echo "The account ${USER_NAME} was deleted."
    else
      chage -E 0 "${USER_NAME}"

      # Check to see if the chage command succeeded.
      # We don't want to tell the user that an account was disabled when it hasn't been.
      if [[ "${?}" -ne 0 ]]
      then
        echo "The account ${USER_NAME} was NOT disabled." >&2
        EXIT_STATUS=1
        continue
      fi
      echo "The account ${USER_NAME} was disabled."
    fi
  fi
done

exit ${EXIT_STATUS}