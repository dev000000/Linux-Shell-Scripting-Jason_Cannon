#!/bin/bash

# This script generates a list of random passwords

# Bonus1: Learn about 'RANDOM' variable in bash
# $RANDOM: Each time this variable is referenced, a random integer between 0 and 32767 is generated 

# 1.A random number as a password.
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

# Bonus2: Learn about shortcut '!' in bash (history expansion)

# The behind of ! is called event designator, which is used to refer to a command in the history list. The event designator can be a number, a string, or a combination of both. The most common event designators are:
# !!: refers to the last command executed.
# !n: refers to the command with the history number n.
# !string: refers to the most recent command that starts with string.
# !?string?: refers to the most recent command that contains string.

# e.g. '!v' commands will search the history for the last command that starts with 'v' and execute it.
# 2.Three random numbers together.
PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

# Bonus3: Learn about 'date' command in bash
# The 'date' command is used to display or set the system date and time.
# The syntax: date [OPTION]... [+FORMAT]
# The '+FORMAT' option is used to specify the output format of the date command:
# %s - seconds since 1970-01-01 00:00:00 UTC (Epoch time, Unix time)
# %N - nanoseconds (000000000..999999999)

#e.g. 'date +%s' command will display -> 1790399479
#e.g. 'date +%s%N' command will display -> 1790400230578586830 ( the last 9 digits are nanoseconds, the first 10 digits are seconds since 1970-01-01 00:00:00 UTC)

# 3. Use the current date/time as the basis for the password.
PASSWORD=$(date +%s)
echo "${PASSWORD}"

# The using date +%s command to generate a password is not secure, because if someone knows the date you generated the password, they can 'brute force' with 86,400 (seconds in a day) possible passwords to find the correct one. In addition, this guy can also assume that the password is generated in business hours, so he can reduce the number of possible passwords to 28,800 (seconds in 8 hours). Therefore, it is not recommended to use this method to generate a password.

# 4. Use nanoseconds to act as randomnization.
PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

# Bonus4: Learn about 'checksum'
# A checksum is numeric value computed for a block of data that is relatively unique, checksums are used to verify the integrity of data such as files, Example, if you download a file from the internet, you can check the checksum of the downloaded file to see if it matches the checksum provided by the website. If they match, it means the file is intact and has not been tampered with. If they do not match, it means the file has been altered or corrupted in some way.
# Big chunk of data and reduce it down to a single number, or a string that represents that chunk of data to verify if it's the same or not.
# e.g. cksum, md5sum, sha1sum, sha256sum, sha512sum, etc.

# Bonus5: Learn about 'head' command in bash
# The 'head' command is used to print the first part of files. 
# Default, it prints the first 10 lines of each file to standard output.
# Option:
# -c, --bytes=[-]K: print the first K bytes of each file.
# -n, --lines=[-]K: print the first K lines instead of the first 10; with the leading '-', print all but the last K lines of each file.

# e.g. 'head -n 1 /etc/passwd' command will display -> root:x:0:0:root:/root:/bin/bash
# e.g. 'head -n1 /etc/passwd' command will display -> root:x:0:0:root:/root:/bin/bash (the space between -n and 1 is optional)
# e.g. 'head -1 /etc/passwd' command will display -> root:x:0:0:root:/root:/bin/bash (the -n is optional)

# 5. A better password
PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "${PASSWORD}"

# 6. An even better password.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "${PASSWORD}"

# Bonus6: Learn about 'shuf' command in bash
# The 'shuf' command is to write a random permutation of the input lines to standard output.
# This means that it takes a list of items and randomly rearranges them, so that the order of the items is different each time you run the command.

# Bonus7: Learn about 'fold' command in bash
# The 'fold' command is used to wrap each input line to fit in specified width.
# The syntax: fold [OPTION]... [FILE]...
# Option:
# -b, --bytes: count bytes rather than columns
# -c, --characters: count columns rather than bytes
# -w, --width=WIDTH: use WIDTH columns instead of 80

# Bonus8: Learn how to develop logical thinking and ideas to create a script that achieves a goad
# First: Has a goal in mind (e.g: random single special character)
# Second: Develop a plan to achieve that goal
# - Display what the special characters are (echo)
# - Changed the output (pipe |) Keep doing this until you get the desired output (shuf, head, fold)

# Linux / Unix phylosphy: each program does one thing and does it well. Therefore, we can combine multiple programs to achieve a goal.

# 7. Append a special character to the password.
SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+{}|:<>?~' | fold -w1 | shuf | head -c1)
echo ${PASSWORD}${SPECIAL_CHARACTER}
