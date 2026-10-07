#!/bin/bash

# This script learn about how to use the userdel command to delete a user account.

# Learn about the userdel command
# The userdel command deletes user accounts and related files.
# Syntax: userdel [options] LOGIN
# Options:
# -f, --force: Force the removal of the user account, even if the user is still logged in. This option also forces the removal of the user's home directory even if the home directory shared with other users. Use this option with caution, as it can lead to data loss.
# Normally, normal user account don't share home directory with other users. but some cases, you might have multiple application accounts that share the same home directory. 
# -r, --remove: Remove the home directory of the user account being deleted.

# See the list of users on the system
echo "List of users on the system:"
tail /etc/passwd
# Output:
# polkitd:x:999:997:User for polkitd:/:/sbin/nologin
# rpc:x:32:32:Rpcbind Daemon:/var/lib/rpcbind:/sbin/nologin
# rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
# nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
# postfix:x:89:89::/var/spool/postfix:/sbin/nologin
# chrony:x:998:996::/var/lib/chrony:/sbin/nologin
# sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
# vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
# vboxadd:x:997:1::/var/run/vboxadd:/bin/false
# test1:x:1001:1002::/home/test1:/bin/bash

# Delete a user account 'test1' using userdel command
echo "Deleting user account 'test1' using userdel command:"
sudo userdel test1 # 

# Check if the user account 'test1' has been deleted
echo "Checking if the user account 'test1' has been deleted:"
id test1 # id command is used to display user ID (UID) and group ID (GID) of a user account.
# Output:
# id: test1: no such user

# Check the list home directories on the system
echo "List of home directories on the system:"
ls -l /home
# Note: userdel command with no options will delete the user account but home directory of the user account will not be deleted.
# Output:
# total 8
# drwx------  2    1001    1002 4096 01:23  6 Th10 test1 
# drwx------. 3 vagrant vagrant 4096 21:49  5 Th10 vagrant

# UID and GID of the user account 'test1' is 1001 and 1002 (actually number) => this mean no account associated with this UID and GID because the account that had the UID of 1001 and GID of 1002 has been deleted. 

# Now, if you run command ls and see UID and GID is displayed instead of the user name and group name, this mean the account that had the UID and GID has been deleted.

# Learn about UID or some users
# root user account has UID of 0 
id -u root # Output: 0
# sshd user account has UID of 74
id -u sshd # Output: 74
# current user account (vagrant) has UID of 1000
id -u # Output: 1000

# System accounts have lower UID
# Rule about UID is actually defined in /etc/login.defs file.
echo "The content of /etc/login.defs file:"
vi /etc/login.defs
# Output:
# ...
# #
# # Min/max values for automatic uid selection in useradd
# #
# UID_MIN                  1000 
# UID_MAX                 60000
# # System accounts
# SYS_UID_MIN               201
# SYS_UID_MAX               999

# #
# # Min/max values for automatic gid selection in groupadd
# #
# GID_MIN                  1000
# GID_MAX                 60000
# # System accounts
# SYS_GID_MIN               201
# SYS_GID_MAX               999
# ...

# => UID_MIN and UID_MAX are 1000 and 60000 respectively => this mean useradd command will assign UID between 1000 and 60000 for normal user accounts.
# => SYS_UID_MIN and SYS_UID_MAX are 201 and 999 respectively => this mean maximum UID for system accounts is 999.
# Note: If you wanna make sure that you're not deleting a very important system account, perhaps it's a good idea to check its UID first. It less than 1000, then it's a system account and you should not delete it (because it could operate a service that you may need on your server). If it's greater than or equal to 1000, then it's a normal user account and you can delete it.

# Add user account 'test2' again using useradd command
echo "Adding user account 'test2' again using useradd command:"
sudo useradd test2

# Check UID of the user account 'test2'
echo "Checking UID of the user account 'test2':"
id -u test2 # Output: 1001

# Delete a user account 'test2' and remove its home directory using userdel command with -r option
echo "Deleting user account 'test2' and removing its home directory using userdel command with
  -r option:"
sudo userdel -r test2

# Check if the user account 'test2' has been deleted
echo "Checking if the user account 'test2' has been deleted:"
id -u test2 # Output: id: test2: no such user

# Check the list home directories on the system
echo "List of home directories on the system:"
ls -l /home
# Output:
# total 8
# drwx------  2    1001    1002 4096 01:23  6 Th10 test1
# drwx------. 3 vagrant vagrant 4096 01:43  6 Th10 vagrant
# => it does not show the home directory of the user account 'test2' because we used -r option with userdel command to remove the home directory of the user account 'test2' when we deleted it.