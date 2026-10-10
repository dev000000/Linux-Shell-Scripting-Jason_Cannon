#!/bin/bash

# This script learn about cut and awk command in bash

# Part1:

# 1. Learn about cut command
# The cut command is used to cutting out sections from each line of input it receives and display those sections to standard output.
# You can use cut command to extract pieces of a line by byte position, character position or by a delimiter.
# This make cut ideal for extracting columns from a CSV file, for example.

# Syntax: cut OPTION... [FILE]...
# Options:
# -b, --bytes=LIST      select only these bytes 
# -c, --characters=LIST select only these characters
# -d, --delimiter=DELIM  use DELIM instead of TAB for field delimiter
# -f, --fields=LIST      select only these fields;  also print any line

# LIST is a comma-separated list of numbers, ranges or both. Ranges are two numbers separated by a hyphen, indicating the start and end of the range. For example, 1-3,5,7-9 would select fields 1, 2, 3, 5, 7, 8 and 9.
# Note: if you not specify first number of a range, it will default the '1' as the starting point. If you not specify the second number of a range, it will default to the last field in the line.
# Example: -3 -> 1-3, 5- -> 5-last field

# Demonstration of cut command
echo "Demonstration of cut command"
echo "1. Using -c option to select characters"
echo "---------------------------------"
# Print the end 10 lines of the /etc/passwd file:
echo "Print the end 5 lines of the /etc/passwd file:"
tail -n 5 /etc/passwd
# Output:
# _rpc:x:131:65534::/run/rpcbind:/usr/sbin/nologin
# statd:x:132:65534::/var/lib/nfs:/usr/sbin/nologin
# libvirt-qemu:x:64055:109:Libvirt Qemu,,,:/var/lib/libvirt:/usr/sbin/nologin
# libvirt-dnsmasq:x:133:140:Libvirt Dnsmasq,,,:/var/lib/libvirt/dnsmasq:/usr/sbin/nologin
# swtpm:x:134:141:virtual TPM software stack,,,:/var/lib/swtpm:/bin/false
# Print the first character of each line
echo "Print the first character of each line:"
tail -5 /etc/passwd | cut -c 1
# Output:
# _
# s
# l
# l
# s

# Print the characters from 3 to 5 of each line
echo "Print the characters from 3 to 5 of each line:"
tail -5 /etc/passwd | cut -c 3-5
# Output:
# pc:
# atd
# bvi
# bvi
# tpm

# Note: When using a range, you must not include any spaces between the numbers and the hyphen. For example, -c 1-3 is valid, but -c 1 - 3 is not.

# Print the every character starting from the 3rd character to the end of each line
echo "Print the every character starting from the 3rd character to the end of each line:"
tail -5 /etc/passwd | cut -c 3-
# Output:
# pc:x:131:65534::/run/rpcbind:/usr/sbin/nologin
# atd:x:132:65534::/var/lib/nfs:/usr/sbin/nologin
# bvirt-qemu:x:64055:109:Libvirt Qemu,,,:/var/lib/libvirt:/usr/sbin/nologin
# bvirt-dnsmasq:x:133:140:Libvirt Dnsmasq,,,:/var/lib/libvirt/dnsmasq:/usr/sbin/nologin
# tpm:x:134:141:virtual TPM software stack,,,:/var/lib/swtpm:/bin/false

# Print the every character starting from the 1st character to the 5th character of each line
echo "Print the every character starting from the 1st character to the 5th character of each line:"
tail -5 /etc/passwd | cut -c -5
# Output:
# _rpc:
# statd
# libvi
# libvi
# swtpm

# Print the characters of 1, 3 and 5 of each line`
echo "Print the characters of 1, 3 and 5 of each line:"
tail -5 /etc/passwd | cut -c 1,3,5
# Output:
# _p:
# sad
# lbi
# lbi
# stm

# Note: The cut command not rearrange the order of the characters. It will print the characters in the order they appear in the line.

echo "Print the characters of 5, 3 and 1 of each line:"
tail -5 /etc/passwd | cut -c 5,3,1 # The output will be the same as the previous command 
# Output:
# _p:
# sad
# lbi
# lbi
# stm

# If you supply a range that doesn't match anything, then you'll get a blank line.
echo "Print the characters 999 of each line:"
tail -5 /etc/passwd | cut -c 999
# Output:
# {blank lines}
# {blank lines}
# {blank lines}
# {blank lines}
# {blank lines}

echo "2. Using -b option to select bytes"
echo "---------------------------------"

# Print the first byte of each line
tail -5 /etc/passwd | cut -b 1
# Output:
# _
# s
# l
# l
# s

# Note: a byte not always equal to a character because there are some characters that made up of multiple bytes (called multibyte characters). For example, the character 'é' is made up of two bytes in UTF-8 encoding.
# In some Linux distributions, the cut command may not handle multibyte characters correctly. It may treat each byte of a multibyte character as a separate character, which can lead to unexpected results when using the -b option. ( Caution when using the -b option with multibyte characters, as it may not produce the expected results. )

# Demonstration of multibyte characters
echo "Demonstration of multibyte characters"
echo "é" | cut -b 1 # Output: {�}

echo "3. Using -f and -d option to select fields"
echo "---------------------------------"

# -f allows you cut lines by fields, and -d allows you to specify the delimiter that separates the fields. By default, cut uses the tab character as the delimiter.
# rule: section before the first delimiter is field 1, section between the first and second delimiter is field 2, and so on. 

# Learn about -e option of echo command
# The -e option of the echo command allow you to use some backslash escape that allow you to do some things like generate a tab character, a new line character, etc. For example, the escape sequence \t will generate a tab character, and the escape sequence \n will generate a new line character. 

# Print the line "one two three" and these words are separated by a tab character
echo -e "one\ttwo\tthree" 
# Output:
# one	two	three

# Print the first field of each line (separated by a tab character)
echo -e "one\ttwo\tthree" | cut -f 1
# Output:
# one	

# If you want to use a different delimiter, you can use the -d option to specify the delimiter.

# Print the first field of each line (separated by a comma)
echo "one,two,three" | cut -d ',' -f 1
# Output:
# one

# Note: Sometimes, you can see someone not use quotes around the delimiter, but it's a good practice to use quotes around the delimiter, especially if the delimiter is a special character like a space or a tab. For example, if you want to use a space as the delimiter, you should use quotes around the space like this: -d ' '.

# In case using some special characters as the delimiter (\, space, tab, etc.), you should use quotes around the delimiter to avoid any issues. For example, if you want to use a space as the delimiter, you should use quotes around the space like this: -d ' '. If you want to use a tab as the delimiter, you should use quotes around the tab like this: -d $'\t'.

# Demonstration of using space as the delimiter
echo "one,two,three" | cut -d , -f 2
# Output:
# two

echo "one,two,three" | cut -d, -f 2
# Output:
# two

# The example above shows that you can use quotes around the delimiter or not


echo "one\two\three" | cut -d \ -f 2 # bash will interpret the '\' between the 'd' and the '-f' as continuation character, so it will not work as expected. You should use quotes around the delimiter like this: -d ' ' or -d $'\t'.


# Print the username and UID of each user in the /etc/passwd file
echo "Print the username and UID of each user in the /etc/passwd file"
tail -5 /etc/passwd | cut -d ':' -f 1,3
# Output:
# _rpc:131
# statd:132
# libvirt-qemu:64055
# libvirt-dnsmasq:133
# swtpm:134


# => output separator is the same as the input separator. If you want to change the output separator, you can use the --output-delimiter option. 

# Print the username and UID of each user in the /etc/passwd file, and change the output separator to a comma
echo "Print the username and UID of each user in the /etc/passwd file, and change the output separator to a comma"
tail -5 /etc/passwd | cut -d ':' --output-delimiter=',' -f 1,3 
# Output:
# _rpc,131
# statd,132
# libvirt-qemu,64055
# libvirt-dnsmasq,133
# swtpm,134

# Common situation that you'll face, you'll have a CSV file with a header or some other type of data that contains a header

# Generate a CSV file for testing
echo 'first,last' > people.csv
echo 'John,Smitt' >> people.csv
echo 'firstly,mclasty' >> people.csv
echo 'Mr. firstly,mclasty' >> people.csv
cat people.csv
# Output:
# first,last
# John,Smitt
# firstly,mclasty
# Mr. firstly,mclasty

# If you extract the first field of each line, you'll get the header as well. 
echo "Extract the first field of each line, you'll get the header as well"
cut -d ',' -f 1 people.csv
# Output:
# first
# John
# firstly
# Mr. firstly

# You want to remove the header from the output
# You have 2 options to remove the header from the output:
# Option 1. Remove the header before you send the data to cut command

# Bonus: Learn about grep command
# The grep command is used to display matches to a pattern that you supply, So if we look for the pattern, it will display the line or lines that match that pattern.

echo "Display all lines that match the pattern 'first' in the people.csv file"
grep first people.csv
# Output:
# first,last
# firstly,mclasty
# Mr. firstly,mclasty

# To narrow down the output, you can provide additional information.
# caret symbol (^) is used to match the beginning of a line (it matches a position and not a character).
# dollar symbol ($) is used to match the end of a line (it matches a position and not a character).

# Example: 

# Match all the lines that start with 'first' in the people.csv file
echo "Match all the lines that start with 'first' in the people.csv file"
grep '^first' people.csv
# Output:
# first,last
# firstly,mclasty

# Match all the lines that end with 't' in the people.csv file
echo "Match all the lines that end with 't' in the people.csv file"
grep 't$' people.csv
# Output:
# first,last
# John,Smitt

# Match all the line exactly matching 'first,last' in the people.csv file
echo "Match all the line exactly matching 'first,last' in the people.csv file"
grep '^first,last$' people.csv
# Output:
# first,last

# => I have the header in the people.csv file, and I want print all the lines except the header, I can use -v option of grep command to invert the match, so it will print all the lines that do not match the pattern.

echo "Print all the lines except the header in the people.csv file"
grep -v '^first,last$' people.csv
# Output:
# John,Smitt
# firstly,mclasty
# Mr. firstly,mclasty

# After that, you can pipe the output to cut command to extract the first field of each line.
echo "Extract the first field of each line, except the header in the people.csv file"
grep -v  '^first,last' people.csv | cut -d ',' -f 1 
# Output:
# John
# firstly
# Mr. firstly

# Option 2. Remove the header after you get the output from cut command

cut -d ',' -f 1 people.csv | grep -v '^first$'
# Output:
# John
# firstly
# Mr. firstly

# Note: cut only handles single-character delimiters. If you want to use a multi-character delimiter, you can use awk command instead of cut command.

# Example:

# Generate a data file for testing
echo 'DATA:firstDATA:last' > people.dat
echo 'DATA:JohnDATA:Smitt' >> people.dat
echo 'DATA:firstlyDATA:mclasty' >> people.dat
echo 'DATA:Mr. firstlyDATA:mclasty' >> people.dat

# Print the original data in the people.dat file
echo "Print the original data in the people.dat file"
cat people.dat
# Output:
# DATA:firstDATA:last
# DATA:JohnDATA:Smitt
# DATA:firstlyDATA:mclasty
# DATA:Mr. firstlyDATA:mclasty

# Use cut command to extract the second field of each line in the people.dat file ( separated by 'DATA:' )
echo "Use cut command to extract the second field of each line in the people.dat file (separated by 'DATA:' )"
cut -d 'DATA:' -f 2 people.dat
# Output:
# cut: the delimiter must be a single character
# Try 'cut --help' for more information.

# 2. Learn about awk command
# The awk command is a powerful text processing tool that allows you to manipulate and analyze text files
# Syntax: awk 'pattern {action}' file
# Example: 
echo "Use awk command to extract the second field of each line in the people.dat file (separated by 'DATA:' )"
awk -F 'DATA:' '{print $2}' people.dat
# Output:
# first
# John
# firstly
# Mr. firstly

# -F option allows you to specify a field separator.
# {} in awk command is used to specify the action. it make awk do something or take actions.
# $x in awk command is used to refer to the x-th field of the current record.

# Compare the output of cut command and awk command
tail -5 /etc/passwd | cut -d ':' -f 1,3
# Output:
# _rpc:131
# statd:132
# libvirt-qemu:64055
# libvirt-dnsmasq:133
# swtpm:134

tail -5 /etc/passwd | awk -F ':' '{print $1,$3}'
# Output:
# _rpc 131
# statd 132
# libvirt-qemu 64055
# libvirt-dnsmasq 133
# swtpm 134

# Between field 1 and field 3, you will see a space instead of a colon. This is because comma in the print statement represents the Output Field Separator (OFS), which is a space by default.


tail -5 /etc/passwd | awk -F ':' '{print $1 $3}' # if you leave a comma between $1 and $3, it will print the fields without any separator.
# Output:
# _rpc131
# statd132
# libvirt-qemu64055
# libvirt-dnsmasq133
# swtpm134

# awk has a special built-in variable called OFS (Output Field Separator) that allows you to specify the output field separator. By default, OFS is a space, but you can change it to any character you want.

# you can use -v option and then perform the variable assignment to change the value of OFS.
tail -5 /etc/passwd | awk -F ':' -v OFS=',' '{print $1 $3}' 
# Output:
# _rpc,131
# statd,132
# libvirt-qemu,64055
# libvirt-dnsmasq,133
# swtpm,134

# instead of using the -v option, you can just give print a string to print, like so.

tail -5 /etc/passwd | awk -F ':' '{print $1 "," $3}' 
# Output:
# _rpc,131
# statd,132
# libvirt-qemu,64055
# libvirt-dnsmasq,133
# swtpm,134

echo "Print the username and UID of each user in the /etc/passwd file"
tail -5 /etc/passwd | cut -d ':' -f 1,3
# Output:
# _rpc:131
# statd:132
# libvirt-qemu:64055
# libvirt-dnsmasq:133
# swtpm:134

# the cut command not change the order of the fields, it will print the fields in the order they appear in the line. But awk command can change the order of the fields, you can print the fields in any order you want.
echo "Print the UID and username of each user in the /etc/passwd file"
tail -5 /etc/passwd | awk -F ':' '{print $3 ":" $1}'
# Output:
# 131:_rpc
# 132:statd
# 64055:libvirt-qemu
# 133:libvirt-dnsmasq
# 134:swtpm

# Bonus: awk command has NF (built-in variable) that represents the number of fields in the current record. $NF represents the last field in the current record. You can use NF to print the last field of each line.
echo "Print the last field of each line in the /etc/passwd file"
tail -5 /etc/passwd | awk -F ':' '{print $NF}'
# Output:
# /bin/bash
# /bin/bash
# /bin/bash
# /bin/bash
# /bin/bash

# With irregular data (different numbers of columns per line), there's often something common at the end of each line. You can use $NF to print the last field of each line, regardless of how many fields there are in each line.

echo "Print the column before the last field of each line in the /etc/passwd file"
tail -5 /etc/passwd | awk -F ':' '{print $(NF - 1)}'
# Output:
# /home/_rpc
# /home/statd
# /home/libvirt-qemu
# /home/libvirt-dnsmasq
# /home/swtpm

# Demonstration of awk command treat multiple spaces as a single space
echo 'L1C1 L1C2' > lines
echo '    L2C1 L2C2    ' >> lines
echo ' L3C1          L3C2' >> lines
echo -e 'L4C1\tL4C2' >> lines
cat lines
# Output:
# L1C1 L1C2
#     L2C1 L2C2
#  L3C1          L3C2
# L4C1    L4C2

# We have files have 4 lines, and each line has 2 columns, but the columns are separated by different number of spaces or tabs.
# With cut this is nearly impossible: it only splits on one character; splitting on a space fails because each line has a different number of spaces; and it can’t handle tabs.
# awk handles it easily, because awk’s default field separator is whitespace (any number of spaces and/or tabs). Put more precisely: awk treats each run of non-whitespace characters as a field. Leading and trailing whitespace is ignored too.

echo "Using awk command to normalize the whitespace and print the first and second columns of each line in the lines file"
awk '{print $1, $2}' lines
# Output:
# L1C1 L1C2
# L2C1 L2C2
# L3C1 L3C2
# L4C1 L4C2

# When you should use awk instead of cut command:
# 1. When you need to use a multi-character delimiter.
# 2. When you handle fields separated by whitespace.

# Part2:
# Goal: List the port number that are open on our local system without any extra data around it.

# First, Learn about netstat command
# The netstat command is used to display network connections, routing tables, interface statistics, masquerade connections, and multicast memberships. It is a useful tool for network troubleshooting and performance measurement.
# Syntax: netstat [OPTION]...
# Options:
# -n, --numeric Show numerical addresses instead of trying to determine symbolic host, port or user names.
# -u, --udp Show UDP connections.
# -t, --tcp Show TCP connections.
# -l, --listening Show only listening sockets.

# Demonstration of netstat command
echo "Demonstration of netstat command"
netstat -nutl
# Output:
# Active Internet connections (only servers)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
# tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN
# tcp6       0      0 :::22                   :::*                    LISTEN
# tcp6       0      0 ::1:25                  :::*                    LISTEN
# udp        0      0 0.0.0.0:10744           0.0.0.0:*
# udp        0      0 127.0.0.1:323           0.0.0.0:*
# udp        0      0 0.0.0.0:68              0.0.0.0:*
# udp6       0      0 :::47728                :::*
# udp6       0      0 ::1:323                 :::*

# You want to eliminate the header of the above output, you have several options to do that.

# Option 1. grep -v twice
echo "Option 1. grep -v twice"
netstat -nutl | grep -v '^Active' | grep -v '^Proto'
# Output:
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
# tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN
# tcp6       0      0 :::22                   :::*                    LISTEN
# tcp6       0      0 ::1:25                  :::*                    LISTEN
# udp        0      0 0.0.0.0:10744           0.0.0.0:*
# udp        0      0 127.0.0.1:323           0.0.0.0:*
# udp        0      0 0.0.0.0:68              0.0.0.0:*
# udp6       0      0 :::47728                :::*
# udp6       0      0 ::1:323                 :::*

# Option 2. use extended regular expression (ERE) with grep command (grep -E )
echo "Option 2. use extended regular expression (ERE) with grep command (grep -E )"
netstat -nutl | grep -Ev '^Proto|^Active'
# | (pipe) in the regular expression means "or", so the above command will match any line that starts with "Proto" or "Active".

# Output:
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
# tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN
# tcp6       0      0 :::22                   :::*                    LISTEN
# tcp6       0      0 ::1:25                  :::*                    LISTEN
# udp        0      0 0.0.0.0:10744           0.0.0.0:*
# udp        0      0 127.0.0.1:323           0.0.0.0:*
# udp        0      0 0.0.0.0:68              0.0.0.0:*
# udp6       0      0 :::47728                :::*
# udp6       0      0 ::1:323                 :::*

# Option 3. keep what the data has in common, every one of them contains a colon (:) in the line, while the two header lines do not.
echo "Option 3. keep what the data has in common, every one of them contains a colon (:) in the line, while the two header lines do not."
netstat -nutl | grep ':'
# Output:
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
# tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN
# tcp6       0      0 :::22                   :::*                    LISTEN
# tcp6       0      0 ::1:25                  :::*                    LISTEN
# udp        0      0 0.0.0.0:10744           0.0.0.0:*
# udp        0      0 127.0.0.1:323           0.0.0.0:*
# udp        0      0 0.0.0.0:68              0.0.0.0:*
# udp6       0      0 :::47728                :::*
# udp6       0      0 ::1:323                 :::*

# At first thought, you may be thinking we can just split this on a colon and print the second field.
echo "At first thought, you may be thinking we can just split this on a colon and print the second field."
netstat -nutl | grep ':' | cut -d ':' -f 2
# Output:
# 22              0.0.0.0
# 25            0.0.0.0


# 10744           0.0.0.0
# 323           0.0.0.0
# 68              0.0.0.0
#
#

# You can see that the output is not what we want, because in case of IPv6, the address contains a colon, so we when we extract the second field, we get the <null> between the first and second colon, which is not what we want. So we need to use a different approach to extract the port number.
# when cut command excute in one line, if not match you will get a blank line, this is reason why we get the blank lines in the output above.

# If you see the input data has lines that separated by random whitespace, so you can think about using awk command
echo "If you see the input data has lines that separated by random whitespace, so you can think about using awk command"
netstat -nutl | grep ':' | awk '{print $4}'
# Output:
# 0.0.0.0:22
# 127.0.0.1:25
# :::22
# ::1:25
# 0.0.0.0:10744
# 127.0.0.1:323
# 0.0.0.0:68
# :::47728
# ::1:323

# And you can see that what data we want is the last part of each line, which is the port number. So we can use awk command to split the line by colon and print the last field.
echo "And you can see that what data we want is the last part of each line, which is the port number. So we can use awk command to split the line by colon and print the last field."
netstat -nutl | grep ':' | awk '{print $4}' | awk -F ":" '{print $NF}'
# Output:
# 22
# 25
# 22
# 25
# 10744
# 323
# 68
# 47728
# 323

# Bonus: If you want to only print v4 addresses, you can use the -4 option of netstat command to only print v4 addresses.
echo "If you want to only print v4 addresses, you can use the -4 option of netstat command to only print v4 addresses."
netstat -4nutl 
# Output:
# Active Internet connections (only servers)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN
# tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN
# udp        0      0 0.0.0.0:10744           0.0.0.0:*
# udp        0      0 127.0.0.1:323           0.0.0.0:*
# udp        0      0 0.0.0.0:68              0.0.0.0:*

# print the port number of each line in the output of netstat command with -4 option
echo "print the port number of each line in the output of netstat command with -4 option"
netstat -4nutl | grep ':' | awk '{print $4}' | awk -F ":" '{print $2}'
# Output:
# 22
# 25
# 10744
# 323
# 68

# print the port number of each line in the output of netstat command with -4 option, and use $NF to print the last field of each line
netstat -4nutl | grep ':' | awk '{print $4}' | awk -F ":" '{print $NF}'
# Output:
# 22
# 25
# 10744
# 323
# 68

# In case you only print v4 addresses, Local Address field will always have 2 fields, so you can use $2 to print the port number of each line. The $NF is more general, it will work for both v4 and v6 addresses, because it will always print the last field of each line, regardless of how many fields there are in each line.


# Bonus: -p option of netstat command can display PID and the name of the program that has the port open. But to get that information, you need to run the command as superuser privileges.

# Demonstration:
# sudo netstat -nutlp
# Output:
# Active Internet connections (only servers)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      898/sshd
# tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      1022/master
# tcp6       0      0 :::22                   :::*                    LISTEN      898/sshd
# tcp6       0      0 ::1:25                  :::*                    LISTEN      1022/master
# udp        0      0 0.0.0.0:10744           0.0.0.0:*                           3111/dhclient
# udp        0      0 127.0.0.1:323           0.0.0.0:*                           630/chronyd
# udp        0      0 0.0.0.0:68              0.0.0.0:*                           3111/dhclient
# udp6       0      0 :::47728                :::*                                3111/dhclient
# udp6       0      0 ::1:323                 :::*                                630/chronyd

# sudo netstat -nutlp | grep '22'
# Output:
# tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      898/sshd
# tcp        0      0 127.0.0.1:25            0.0.0.0:*               LISTEN      1022/master
# tcp6       0      0 :::22                   :::*                    LISTEN      898/sshd
# tcp6       0      0 ::1:25                  :::*                    LISTEN      1022/master

# => this shows is that we have SSHD with a pid of 898 listening on port 22.