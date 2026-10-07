#!/bin/bash
# This script disables, deletes, and optionally archives a local user account. (Script for documents/Exercise-05-Deleting-Local-Users-04.pdf)

local ACTION=''
# usage function: show usage information for user.
usage() {
  echo "Usage: ${0} [options] [USERNAME...]"
  echo " ${0} - disables (by default), deletes, optionally archives a local user account "
  echo "Option:"
  echo " -d, --delete   Deletes accounts instead of disabling them."
  echo " -r, --remove   Removes the home directory associated with the account(s)."
  echo " -a, --archive  Creates an archive of the home directory associated with the accounts(s) and stores
the archive in the /archives directory. "
  echo " -D, --disable  (expires/locks) accounts (default)"
  exit 1
 }
  
# Check recent command is success or not 
check() {
  local MESSAGE="${1}"
  if [[ "${?}" -eq 0 ]]
  then
    echo "${MESSAGE}"
    exit 1
  fi
}
# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]]
then
  echo 'Please run with sudo or as root.' >&2
  exit 1
fi


while getopts dra OPTION
do
  case ${OPTION} in
    d|delete)
      local DELETE_USER='true'
      ;;
    r|remove)
      local REMOVE_HOME_DIRECTORY='true'
      ;;
    a|archive)
      local ARCHIVE_HOME_DIRECTORY='true'
      ;;
    *)
      usage
      ;;
  esac
done

shift "$(( OPTIND - 1 ))"

# At least one username is required
if [[ "${#}" -lt 1 ]]
then 
  usage
  exit 1
fi

# 
while [[ "${#}" -gt 0 ]]
do
  local USER_NAME="${1}"
  shift 1
  # check user is system account or not 
  if [[ $(( id -u ${USER_NAME} )) -lt 1000 ]]
  then
    echo "You can not working with system account: ${USER_NAME}" >&2
    exit 1
  else
    # check user want to archive home directory
    if [[ "${ARCHIVE_HOME_DIRECTORY}" = "true" ]]
    then
      # Append action archive to the ACTION variable.
      ACTION+="Archiving home directory"
      # check /archives existed or not 
      if [[ ! -d "/archives" ]]
      then
        mkdir '/archives'
      fi
      # archive home directory
      cd /archives
      sudo tar -cf home_directory_${USER_NAME}.tar /home/${USERNAME}
      check "Archive home directory not successfully"
    fi
    
    # check user want to delete or disable 
    if [[ "${DELETE_USER}" = "true" ]]
    then
      # Append action delete to the ACTION variable.
      ACTION+=",Deleting user"
      # check user want to remove home directory or not
      if [[ "${REMOVE_HOME_DIRECTORY}" = "true" ]]
      then
        # Append action remove to the ACTION variable.
        ACTION+=",Removing home directory"
        sudo userdel -r "${USER_NAME}"
      else
        sudo userdel "${USER_NAME}"
      fi
      check 'Remove user not successfully'
    else
      # if not delete => disable ( default )
      # Append action disable to the ACTION variable.
      ACTION+=",Disabling user"
      sudo chage -E 0 "${USER_NAME}"
    fi
    echo "Successfully ${ACTION} for user: ${USER_NAME}"
  fi
done

exit 0
    
      
    
      
      
  
    
    
  
      
     
    
