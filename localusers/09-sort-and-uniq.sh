#!/bin/bash

# This script is used to learn how to sort data using sort and uniq commands in Linux.

# Display the /etc/passwd file
echo "Displaying the /etc/passwd file:"
cat /etc/passwd
# Output:
# root:x:0:0:root:/root:/bin/bash
# bin:x:1:1:bin:/bin:/sbin/nologin
# daemon:x:2:2:daemon:/sbin:/sbin/nologin
# adm:x:3:4:adm:/var/adm:/sbin/nologin
# lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
# sync:x:5:0:sync:/sbin:/bin/sync
# shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
# halt:x:7:0:halt:/sbin:/sbin/halt
# mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
# operator:x:11:0:operator:/root:/sbin/nologin
# games:x:12:100:games:/usr/games:/sbin/nologin
# ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
# nobody:x:99:99:Nobody:/:/sbin/nologin
# systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
# dbus:x:81:81:System message bus:/:/sbin/nologin
# polkitd:x:999:997:User for polkitd:/:/sbin/nologin
# rpc:x:32:32:Rpcbind Daemon:/var/lib/rpcbind:/sbin/nologin
# rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
# nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
# postfix:x:89:89::/var/spool/postfix:/sbin/nologin
# chrony:x:998:996::/var/lib/chrony:/sbin/nologin
# sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
# vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
# vboxadd:x:997:1::/var/run/vboxadd:/bin/false

# If you want to sort the contents of a file alphabetically, you can use the sort command. For example, to sort the /etc/passwd file, you can run:
echo "Sorting the /etc/passwd file:"
sort /etc/passwd
# Output:
# adm:x:3:4:adm:/var/adm:/sbin/nologin
# bin:x:1:1:bin:/bin:/sbin/nologin
# chrony:x:998:996::/var/lib/chrony:/sbin/nologin
# daemon:x:2:2:daemon:/sbin:/sbin/nologin
# dbus:x:81:81:System message bus:/:/sbin/nologin
# ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
# games:x:12:100:games:/usr/games:/sbin/nologin
# halt:x:7:0:halt:/sbin:/sbin/halt
# lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
# mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
# nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
# nobody:x:99:99:Nobody:/:/sbin/nologin
# operator:x:11:0:operator:/root:/sbin/nologin
# polkitd:x:999:997:User for polkitd:/:/sbin/nologin
# postfix:x:89:89::/var/spool/postfix:/sbin/nologin
# root:x:0:0:root:/root:/bin/bash
# rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
# rpc:x:32:32:Rpcbind Daemon:/var/lib/rpcbind:/sbin/nologin
# shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
# sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
# sync:x:5:0:sync:/sbin:/bin/sync
# systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
# vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
# vboxadd:x:997:1::/var/run/vboxadd:/bin/false

# If you want to reverse the order of the sort, you can use the -r option. 
echo "Sorting the /etc/passwd file in reverse order:"
sort -r /etc/passwd
# Output:
# vboxadd:x:997:1::/var/run/vboxadd:/bin/false
# vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
# systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
# sync:x:5:0:sync:/sbin:/bin/sync
# sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
# shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
# rpc:x:32:32:Rpcbind Daemon:/var/lib/rpcbind:/sbin/nologin
# rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
# root:x:0:0:root:/root:/bin/bash
# postfix:x:89:89::/var/spool/postfix:/sbin/nologin
# polkitd:x:999:997:User for polkitd:/:/sbin/nologin
# operator:x:11:0:operator:/root:/sbin/nologin
# nobody:x:99:99:Nobody:/:/sbin/nologin
# nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
# mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
# lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
# halt:x:7:0:halt:/sbin:/sbin/halt
# games:x:12:100:games:/usr/games:/sbin/nologin
# ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
# dbus:x:81:81:System message bus:/:/sbin/nologin
# daemon:x:2:2:daemon:/sbin:/sbin/nologin
# chrony:x:998:996::/var/lib/chrony:/sbin/nologin
# bin:x:1:1:bin:/bin:/sbin/nologin
# adm:x:3:4:adm:/var/adm:/sbin/nologin

# Extract the UID numbers from the /etc/passwd file
echo "Extracting the UID numbers from the /etc/passwd file:"
cut -d ':' -f 3 /etc/passwd
# Output:
# 0
# 1
# 2
# 3
# 4
# 5
# 6
# 7
# 8
# 11
# 12
# 14
# 99
# 192
# 81
# 999
# 32
# 29
# 65534
# 89
# 998
# 74
# 1000
# 997

# You can pipe the output of the cut command to the sort command 
echo "Sorting the UID numbers from the /etc/passwd file:"
cut -d ':' -f 3 /etc/passwd | sort
# Output:
# 0
# 1
# 1000
# 11
# 12
# 14
# 192
# 2
# 29
# 3
# 32
# 4
# 5
# 6
# 65534
# 7
# 74
# 8
# 81
# 89
# 99
# 997
# 998
# 999

# You can see that the list is sorted but not is what you want. because the sort command compares the characters in each string one by one, from left to right. based on their character values, rather than comparing the numbers as whole numberic values.

# You can use the -n option to sort the numbers as whole numeric values.
cut -d ':' -f 3 /etc/passwd | sort -n
# Output:
# 0
# 1
# 2
# 3
# 4
# 5
# 6
# 7
# 8
# 11
# 12
# 14
# 29
# 32
# 74
# 81
# 89
# 99
# 192
# 997
# 998
# 999
# 1000
# 65534

# Learn about du command.
# du command is used to estimate file space usage. 
# du stand for disk usage.
# It can be used to find out the size of a directory and its contents, or to find out how much space a file is taking up on the disk.

# Demonstration of du command.
echo "Demonstration of du command: check disk usage of /var directory:"
sudo du /var
# Output:
# ...
# 4       /var/cache/man/it/cat5
# 4       /var/cache/man/it/cat3
# 40      /var/cache/man/it
# 4       /var/cache/man/cat3
# 1704    /var/cache/man
# 1732    /var/cache
# 111068  /var

# The first column is the size of the file or directory (default: kilobytes).
# The second column is the name of the file or directory.

# Use sort command to find out which directory in /var is using the most space.
echo "Finding out which directory in /var is using the most space:"
sudo du /var | sort -n
# Output:
# ...
# 1732    /var/cache
# 1776    /var/lib/mlocate
# 5244    /var/lib/yum/yumdb
# 6072    /var/lib/yum
# 99532   /var/lib/rpm
# 107708  /var/lib * this is the sub directory of /var that is using the most space. *
# 111068  /var 

# You can use the -h option to display the sizes in a human-readable format (e.g., KB, MB, GB).
echo "Displaying the sizes in a human-readable format:"
sudo du -h /var
# Output:
# ...
# 4.0K    /var/cache/man/it/cat5
# 4.0K    /var/cache/man/it/cat3
# 40K     /var/cache/man/it
# 4.0K    /var/cache/man/cat3
# 1.7M    /var/cache/man
# 1.7M    /var/cache
# 109M    /var

# If you using sort without no option to sort the output of du -h command, it not work as expected 

echo "Sorting the output of du -h command:"
sudo du -h /var | sort
# Output:
# ...
# 84K     /var/lib/yum/yumdb/t
# 920K    /var/lib/yum/yumdb/l
# 96K     /var/lib/yum/yumdb/N
# 98M     /var/lib/rpm

# Even you use the -n option to sort the output of du -h command, it not work as expected because the sort command does not understand the human-readable sizes (e.g., KB, MB, GB). It only compares the number sections, not the unit sections. So, it will sort the sizes based on the number sections only, and ignore the unit sections.

echo "Sorting the output of du -h command with -n option:"
sudo du -h /var | sort -n
# Output:
# ...
# 84K     /var/lib/yum/yumdb/t
# 96K     /var/lib/yum/yumdb/N
# 98M     /var/lib/rpm # 98M > 100K
# 100K    /var/lib/yum/yumdb/a
# 100K    /var/lib/yum/yumdb/e
# 100K    /var/spool

# Luckily, the sort command has a -h option that perform a human-readable sort.

echo "Sorting the output of du -h command with -h option:"
sudo du -h /var | sort -h
# Output:
# ...
# 920K    /var/lib/yum/yumdb/l
# 1.4M    /var/log
# 1.7M    /var/cache
# 1.7M    /var/cache/man
# 1.8M    /var/lib/mlocate
# 5.2M    /var/lib/yum/yumdb

# Let's go to next example

# In previous example, we have learned to list a listening port in local system using netstat command.
echo "Listing listening ports in local system:"
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'
# Output:
# 22
# 25
# 22
# 25
# 51429
# 323
# 68
# 16297
# 323

echo "Sorting the listening ports in local system:"
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n
# Output:
# 22
# 22
# 25
# 25
# 68
# 323
# 323
# 16297
# 51429

# You can see the output above is sorted but not unique. You can use the -u option to sort the output and remove the duplicates.

echo "Sorting the listening ports in local system and removing duplicates:"
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -nu
# Output:
# 22
# 25
# 68
# 323
# 16297
# 51429

# Learn about uniq command.
# uniq command is used to remove duplicate lines from a sorted file. It quite similar to sort command.
# Important: uniq requires the input to be sorted because it only compares current line with the previous line. 

# Sorting the listening ports in local system and removing duplicates using uniq command:
echo "Sorting the listening ports in local system and removing duplicates using uniq command:"
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n |  uniq
# Output:
# 22
# 25
# 68
# 323
# 16297
# 51429

# Demonstration of uniq command not working in case the input is not sorted:
echo "Demonstration of uniq command not working in case the input is not sorted:"
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | uniq
# Output:
# 22
# 25 *this line is compared with the previous line (22) and since they are not the same, it is printed.*
# 22 *this line is compared with the previous line (25) and since they are not the same, it is printed.*
# 25
# 51429
# 323
# 68
# 16297
# 323

# At this point, you should have a question in your mind, why would you ever want to use the uniq command if you have to give it sorted data anyway and sort already has a -u option ?
# Well, when you want to know how many occurrences of each line there were, use uniq -c 

echo "Counting the occurrences of each listening port in local system:"
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}' | sort -n | uniq -c
# Output:
# 2 22
# 2 25
# 1 68
# 2 323
# 1 16297
# 1 51429

# The first column is the number of times the line appeared in the output.
# The second column is the line itself.

# Example: If you want to find out how many syslog messages a program is generating, you can use the following command:

# Print syslog messages file
echo "Printing syslog messages file:"
cat /var/log/messages
# Output:
# ...
# Oct  4 10:34:01 localusers systemd: Removed slice User Slice of root.
# Oct  4 10:34:01 localusers systemd: Stopping User Slice of root.
# Oct  4 10:45:27 localusers chronyd[618]: Source 2400:d760:0:ff09::123 replaced with 2400:e920:0:5::14
# Oct  4 11:01:01 localusers systemd: Created slice User Slice of root.

# If you can see, the 5th column is the name of the program that generated the message. You can use awk to extract the 5th column and then use sort and uniq to count the occurrences of each program. After that, you can use sort -n to sort the output by the number of occurrences.
echo "Counting the occurrences of each program that generated syslog messages:"
cat /var/log/messages | awk '{print $5}' | sort | uniq -c | sort -n
# Output:
    #  13 NetworkManager[630]:
    #  32 nm-dispatcher:
    #  34 systemd-logind:
    #  35 systemd[1]:
    #  73 chronyd[630]:
    # 163 NetworkManager[614]:
    # 393 kernel:
    # 461 systemd

# Learn about wc command.
# wc command is used to count the number of lines, words, and characters in a file
# wc stand for word count.
# syntax: wc [options] [file]
# Options:
# -l: count the number of lines
# -w: count the number of words
# -c: count the number of characters
# Note: wc really doesn't understand language, It considers a word to be any non-zero link sequence of characters delimited by whitespace.
# Demonstration of wc command:
echo "Counting the number of lines, words, and characters in /etc/passwd file:"
wc /etc/passwd
# Output:
# 24   37 1131 /etc/passwd
# The first column is the number of lines (24)
# The second column is the number of words (37)
# The third column is the number of characters (1131)

echo "Counting the number of lines in /etc/passwd file:"
wc -l /etc/passwd
# Output:
# 24 /etc/passwd
# in this case, you can know that local system has 24 local users, because each line in /etc/passwd file represents a local user.

echo "Counting the number of words in /etc/passwd file:"
wc -w /etc/passwd
# Output:
# 37 /etc/passwd

echo "Counting the number of characters in /etc/passwd file:"
wc -c /etc/passwd
# Output:
# 1131 /etc/passwd

# We want to know how many accounts are using the bash shell.

# You can grep bash from /etc/passwd file and then use wc -l to count the number of lines in the output.
grep 'bash' /etc/passwd | wc -l
# Output:
# 2

# You can also use -c option of grep to count the number of lines that match the pattern.
grep -c 'bash' /etc/passwd
# Output:
# 2

# There's one last option to sort that is very useful, the -k option. It allows you to specify a sort key, Normally, sort will sorting on the very first bit of data in a line. If you have data separated into multiple fields, and you want to sort on a field other than the first one.

# You want to sort the /etc/passwd file by the UID number.

# 1. Display the /etc/passwd file
echo "Displaying the /etc/passwd file:"
cat /etc/passwd
# Output:
# root:x:0:0:root:/root:/bin/bash
# bin:x:1:1:bin:/bin:/sbin/nologin
# daemon:x:2:2:daemon:/sbin:/sbin/nologin
# adm:x:3:4:adm:/var/adm:/sbin/nologin
# lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
# sync:x:5:0:sync:/sbin:/bin/sync
# shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
# halt:x:7:0:halt:/sbin:/sbin/halt
# mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
# operator:x:11:0:operator:/root:/sbin/nologin
# games:x:12:100:games:/usr/games:/sbin/nologin
# ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
# nobody:x:99:99:Nobody:/:/sbin/nologin
# systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
# dbus:x:81:81:System message bus:/:/sbin/nologin
# polkitd:x:999:997:User for polkitd:/:/sbin/nologin
# rpc:x:32:32:Rpcbind Daemon:/var/lib/rpcbind:/sbin/nologin
# rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
# nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin
# postfix:x:89:89::/var/spool/postfix:/sbin/nologin
# chrony:x:998:996::/var/lib/chrony:/sbin/nologin
# sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
# vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
# vboxadd:x:997:1::/var/run/vboxadd:/bin/false

# 2. You can see UID number is the 3rd field in each line and the fields are separated by ':' character. by default, sort command uses whitespace as the field separator.
# You can use the -t option to specify a different field separator.
# You can use the -k option to specify the sort key. The sort key is the field number that you want to sort on.

sort -t ':' -k 3 /etc/passwd
# Output:
# root:x:0:0:root:/root:/bin/bash
# bin:x:1:1:bin:/bin:/sbin/nologin
# daemon:x:2:2:daemon:/sbin:/sbin/nologin
# adm:x:3:4:adm:/var/adm:/sbin/nologin
# lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
# sync:x:5:0:sync:/sbin:/bin/sync
# shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
# halt:x:7:0:halt:/sbin:/sbin/halt
# mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
# operator:x:11:0:operator:/root:/sbin/nologin
# games:x:12:100:games:/usr/games:/sbin/nologin
# ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
# rpcuser:x:29:29:RPC Service User:/var/lib/nfs:/sbin/nologin
# rpc:x:32:32:Rpcbind Daemon:/var/lib/rpcbind:/sbin/nologin
# sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
# dbus:x:81:81:System message bus:/:/sbin/nologin
# postfix:x:89:89::/var/spool/postfix:/sbin/nologin
# nobody:x:99:99:Nobody:/:/sbin/nologin
# systemd-network:x:192:192:systemd Network Management:/:/sbin/nologin
# vboxadd:x:997:1::/var/run/vboxadd:/bin/false
# chrony:x:998:996::/var/lib/chrony:/sbin/nologin
# polkitd:x:999:997:User for polkitd:/:/sbin/nologin
# vagrant:x:1000:1000:vagrant:/home/vagrant:/bin/bash
# nfsnobody:x:65534:65534:Anonymous NFS User:/var/lib/nfs:/sbin/nologin

# Demonstration on how to analyze a web server log file using sort and uniq commands.
# You wanna know how many times a particular URL was visited.

# I have a web server log file named access_log
echo "The content of the web server log file access_log:"
cat access_log
# Output:
# ...
# 208.60.15.88 - - [09/Jan/2018:13:39:48 -0800] "GET /list HTTP/1.0" 200 4979 "http://morissettehand.org/tags/home.php" "Mozilla/5.0 (X11; Linux i686; rv:1.9.5.20) Gecko/2017-06-28 17:11:24 Firefox/3.6.10"
# 170.81.27.53 - - [09/Jan/2018:13:41:28 -0800] "PUT /list HTTP/1.0" 200 4958 "http://swift.info/" "Mozilla/5.0 (Windows NT 5.1; en-US; rv:1.9.1.20) Gecko/2010-12-03 05:06:26 Firefox/3.6.12"
# 23.122.132.106 - - [09/Jan/2018:13:46:07 -0800] "PUT /wp-content HTTP/1.0" 200 4949 "http://turner.com/post.html" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/5310 (KHTML, like Gecko) Chrome/14.0.893.0 Safari/5310"
# 6.72.116.253 - - [09/Jan/2018:13:48:52 -0800] "GET /wp-content HTTP/1.0" 200 4957 "http://bashirian.biz/category/" "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/5352 (KHTML, like Gecko) Chrome/13.0.801.0 Safari/5352"
# 227.165.113.220 - - [09/Jan/2018:13:51:49 -0800] "DELETE /wp-admin HTTP/1.0" 301 4971 "http://barton.org/main/about.htm" "Mozilla/5.0 (iPod; U; CPU iPhone OS 3_3 like Mac OS X; it-IT) AppleWebKit/532.26.7 (KHTML, like Gecko) Version/3.0.5 Mobile/8B117 Safari/6532.26.7"

# You can notice that the URL is the 2th field in each line and the fields are separated by " double quote character or the URL is also the 7th field in each line and the fields are separated by white space. You can use awk to extract the URL from the log file. (this is the easiest way to extract the URL from the log file, don't need step 2)

echo "Step 1: Extracting the URL from the log file:"
cut -d '"' -f 2 access_log 
# Output:
# GET /list HTTP/1.0
# PUT /list HTTP/1.0
# PUT /wp-content HTTP/1.0
# GET /wp-content HTTP/1.0
# DELETE /wp-admin HTTP/1.0

# As you can see, the URL section is the 2th field in each line and the fields are separated by white space.
echo "Step 2: Extracting the URL from the log file:"
cut -d '"' -f 2 access_log | awk '{print $2}'
# Output:
# /list
# /list
# /wp-content
# /wp-content
# /wp-admin



# Now you can use sort and uniq to count the occurrences of each URL.
cut -d '"' -f 2 access_log | awk '{print $2}' | sort | uniq -c | sort -n
# Output:
# ...
# 1229 /app/main/posts
# 1232 /wp-content
# 1238 /list
# 1240 /search/tag/list
# 1259 /posts/posts/explore
# 1265 /explore
# 1271 /wp-admin

# Only display the top 3 most visited URLs
cut -d '"' -f 2 access_log | awk '{print $2}' | sort | uniq -c | sort -n | tail -3
# Output:
  #  1259 /posts/posts/explore
  #  1265 /explore
  #  1271 /wp-admin