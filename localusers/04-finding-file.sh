#!/bin/bash

# This script learn about how to find a command or file that isn't in your PATH.

# Try to find 'userdel' command using type command
echo "Finding 'userdel' command using type command:"
type -a userdel # Output: userdel is /usr/sbin/userdel

# Try to find 'userdel' command using which command
echo "Finding 'userdel' command using which command:"
which userdel # Output: /usr/bin/which: no userdel in (/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/sbin:/home/vagrant/bin)

# => When see the output of the which, type command this error has two possible explainations:
# 1. The command really doesn't exist on the system.
# 2. The command exists, but it is not in your PATH.

# Learn how to find a command that isn't in your PATH 

# Method 1: locate command
# Most Linux distro have 'locate' installed and configured.
# The locate command searches an index (database) that is created by the updatedb command.
# updatedb command is typically scheduled to run once a day. 

# advantage: very fast
# disadvantage: the index may be out of date, not real-time

# Syntax: locate <filename>
echo "Finding 'userdel' command using locate command:"
locate userdel 
# Output: 
# /usr/sbin/luserdel
# /usr/sbin/userdel
# /usr/share/bash-completion/completions/userdel
# /usr/share/man/de/man8/userdel.8.gz
# /usr/share/man/fr/man8/userdel.8.gz
# /usr/share/man/it/man8/userdel.8.gz
# /usr/share/man/ja/man8/userdel.8.gz
# /usr/share/man/man1/luserdel.1.gz
# /usr/share/man/man8/userdel.8.gz
# /usr/share/man/pl/man8/userdel.8.gz
# /usr/share/man/ru/man8/userdel.8.gz
# /usr/share/man/sv/man8/userdel.8.gz
# /usr/share/man/tr/man8/userdel.8.gz
# /usr/share/man/zh_CN/man8/userdel.8.gz
# /usr/share/man/zh_TW/man8/userdel.8.gz

# Providing that locate doesn't use real-time data
touch userdel # Create a file called userdel in the current directory (/home/vagrant)
echo "Finding 'userdel' command using locate command after creating a file called userdel in the current directory:"
locate userdel 
# Output: 
# /usr/sbin/luserdel
# /usr/sbin/userdel
# /usr/share/bash-completion/completions/userdel
# /usr/share/man/de/man8/userdel.8.gz
# /usr/share/man/fr/man8/userdel.8.gz
# /usr/share/man/it/man8/userdel.8.gz
# /usr/share/man/ja/man8/userdel.8.gz
# /usr/share/man/man1/luserdel.1.gz
# /usr/share/man/man8/userdel.8.gz
# /usr/share/man/pl/man8/userdel.8.gz
# /usr/share/man/ru/man8/userdel.8.gz
# /usr/share/man/sv/man8/userdel.8.gz
# /usr/share/man/tr/man8/userdel.8.gz
# /usr/share/man/zh_CN/man8/userdel.8.gz
# /usr/share/man/zh_TW/man8/userdel.8.gz
sudo updatedb # Update the index (database) for locate command -> updatedb needs sudo permission to run because it needs to read all files on the system to update the index.
echo "Finding 'userdel' command using locate command after updating the index (database) for locate command:"
locate userdel
# Output:
# /usr/sbin/luserdel
# /usr/sbin/userdel
# /usr/share/bash-completion/completions/userdel
# /usr/share/man/de/man8/userdel.8.gz
# /usr/share/man/fr/man8/userdel.8.gz
# /usr/share/man/it/man8/userdel.8.gz
# /usr/share/man/ja/man8/userdel.8.gz
# /usr/share/man/man1/luserdel.1.gz
# /usr/share/man/man8/userdel.8.gz
# /usr/share/man/pl/man8/userdel.8.gz
# /usr/share/man/ru/man8/userdel.8.gz
# /usr/share/man/sv/man8/userdel.8.gz
# /usr/share/man/tr/man8/userdel.8.gz
# /usr/share/man/zh_CN/man8/userdel.8.gz
# /usr/share/man/zh_TW/man8/userdel.8.gz
# /vagrant/userdel -> This is the file we created in the current directory (/home/vagrant)


# Bonus1: You can use 'grep' command to filter the output of locate command to find the exact file you are looking for.
# grep command displays matches to a pattern and discards everything else.
# You are looking for a binary (executable file) called 'userdel', so you can filter the output of locate command to only show files that are in /bin or /sbin directories.
echo "Finding 'userdel' command using locate command and filtering the output to only show files that are in /bin"
locate userdel | grep bin
# Output:
# /usr/sbin/luserdel
# /usr/sbin/userdel

# Note: The locate command honors permissions, so if you run locate as a normal user, it will only show files that the user has permission to read. If you run locate as root, it will show all files on the system.
# Example:
echo "Finding '.bashrc' file using locate command as a normal user:"
locate .bashrc 
# Output: 
# /etc/skel/.bashrc
# /home/vagrant/.bashrc

echo "Finding '.bashrc' file using locate command as root:"
sudo locate .bashrc
# Output:
# /etc/skel/.bashrc
# /home/vagrant/.bashrc
# /root/.bashrc

# Bonus2: You can use "!!" ( double exclamation mark | bang bang) to repeat the last command. !! represent the last command you ran.

# Method 2: Use knowledge of the file system hierarchy and then start looking in places where the file might live.
# If you looking for a configuration file => /etc
# If you looking for a binary (executable file) => /bin, /sbin
# System admin commands => /sbin
# Normal commands that all users can run => /bin

# Method 3: Use find command
# The find command searches the file system in real-time, recursively, so it is slower than locate command
# Syntax: find <path> <options> <expression> <pattern> *if you don't specify a path, find will search the current directory and all subdirectories*

echo "Searching in /usr/bin directory:"
find /usr/bin 
# Output:
# /usr/bin
# /usr/bin/splain
# /usr/bin/colrm
# /usr/bin/nmtui-connect
# /usr/bin/bzip2
# /usr/bin/db_load
# /usr/bin/zipnote
# /usr/bin/db_log_verify
# /usr/bin/quotasync
# /usr/bin/lchfn
# /usr/bin/mailq.postfix
# /usr/bin/fmt
#......
# /usr/bin/msgcat

echo "Searching in /usr/sbin directory for 'userdel' command:"
find /usr/sbin -name userdel
# Output: /usr/sbin/userdel

echo "Searching entire file system for 'userdel' command:"
find / -name userdel
# Output:
# find: ‘/root’: Permission denied
# /vagrant/userdel
# find: ‘/vagrant/test’: Operation not permitted
# find: ‘/proc/tty/driver’: Permission denied
# find: ‘/proc/1/task/1/fd’: Permission denied
# find: ‘/proc/1/task/1/fdinfo’: Permission denied
# find: ‘/proc/1/task/1/ns’: Permission denied
# find: ‘/proc/1/fd’: Permission denied
# find: ‘/proc/1/map_files’: Permission denied

# In here you can use 2 options to avoid the permission denied error:
# 1. Use sudo to run the find command as root user (in case file you are looking for is in a directory that requires root permission to access)
echo "Searching entire file system for 'userdel' command using sudo:"
sudo find / -name userdel
# Output:
# /vagrant/userdel
# find: ‘/vagrant/test’: Operation not permitted
# /usr/sbin/userdel
# /usr/share/bash-completion/completions/userdel
# 2. Use 2> /dev/null to redirect the error output to /dev/null (in case you don't want to see the permission denied error)
echo "Searching entire file system for 'userdel' command and redirecting the error output to
  /dev/null:"
find / -name userdel 2> /dev/null
# Output:
# /vagrant/userdel
# /usr/sbin/userdel
# /usr/share/bash-completion/completions/userdel
