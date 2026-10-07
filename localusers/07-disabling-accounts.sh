#!/bin/bash

# This script learn how to disable, lock, and unlock a user account.

# Method 1: Using 'chage' command to disable a user account (Best practice)
# chage command is used to change user account password expiry information.
# change stand for change age of user account password expiry information.
# Syntax: chage [options] LOGIN
# Options:
# -E, --expiredate EXPIRE_DATE: Set the date or number of days since Jan 1, 1970, on which the user account will no longer be accessible. 
# The date may also be expressed in the format YYYY-MM-DD. 
# Passing the number -1 as the EXPIRE_DATE will remove an account expiration date.

# Create some user accounts to demonstrate the disable and lock/unlock user account.
echo "Creating user accounts 'alex' and 'john' to demonstrate the disable and lock/unlock user account:"
sudo useradd alex
echo "password1" | sudo passwd --stdin alex # Set password for alex
sudo useradd john
echo "password2" | sudo passwd --stdin john # Set password for john

# Check the list of users on the system
echo "List of users on the system:"
tail /etc/passwd
# Output:
# rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
# nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
# postfix:x:89:89::/var/spool/postfix:/sbin/nologin
# chrony:x:998:996::/var/lib/chrony:/sbin/nologin
# sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
# vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
# vboxadd:x:997:1::/var/run/vboxadd:/bin/false
# test1:x:1001:1002::/home/test1:/bin/bash
# alex:x:1002:1003::/home/alex:/bin/bash 
# john:x:1003:1004::/home/john:/bin/bash

# Expire the user account 'alex' using chage command
echo "Disabling user account 'alex' using chage command:"
sudo chage -E 0 alex 

# Login as user 'alex' to test if the account is disabled
echo "Trying to login as user 'alex' to test if the account is disabled:"
su - alex 
# Typing password for alex: password1
# Output:
# Your account has expired; please contact your system administrator
# su: User account has expired


# Unlock the user account 'alex' using chage command
echo "Unlocking user account 'alex' using chage command:"
sudo chage -E -1 alex

# Login as user 'alex' to test if the account is unlocked
echo "Trying to login as user 'alex' to test if the account is unlocked:"
su - alex 
# Typing password for alex: password1
# Output: Successfully logged in as user 'alex'

# Method 2: Using passwd with -l option to lock a user account (older method)

# Lock the user account 'john' using passwd command with -l option
echo "Locking user account 'john' using passwd command with -l option:"
sudo passwd -l john
# Output:
# Locking password for user john.
# passwd: Success

# Unlock the user account 'john' using passwd command with -u option
echo "Unlocking user account 'john' using passwd command with -u option:"
sudo passwd -u john
# Output:
# Unlocking password for user john.
# passwd: Success

# Note: The passwd command with -l option like this does not prevent a user authenticating with SSH keys. That's very important to know because using SSH keys as our primary method of authentication, So if you want to lock a user account, you should use chage command with -E option to expire the user account. 

# Method 3: Set the shell of the user account to /sbin/nologin to disable a user account (using usermod command)

# Look at the available shells on a system
echo "Available shells on the system:"
cat /etc/shells
# Output:
# /bin/sh
# /bin/bash
# /sbin/nologin
# /usr/bin/sh
# /usr/bin/bash
# /usr/sbin/nologin

# Set the shell of the user account 'alex' to /sbin/nologin using usermod command
echo "Setting the shell of the user account 'alex' to /sbin/nologin
  using usermod command:"
sudo usermod -s /sbin/nologin alex

# Note: Setting the shell to /sbin/nologin with usermod does NOT really disable the account.
# It only blocks the interactive shell: nologin just prints a message and exits, so both an
# interactive SSH login and remote command execution (ssh user@host "cmd", which runs
# shell -c "cmd") will fail.
# However, if the SSH key is still valid, SSH features that do NOT need a shell keep working:
#   - Port forwarding / tunneling (ssh -N -L / -R / -D SOCKS proxy)
#   - SFTP when sshd is configured with 'Subsystem sftp internal-sftp'
# So the account is not truly disabled. 