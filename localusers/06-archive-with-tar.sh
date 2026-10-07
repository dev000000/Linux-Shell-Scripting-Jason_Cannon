#!/bin/bash

# This script will learn about how to archive, compress, and extract files 


# Learn about the tar command
# The tar command is used to create and manipulate archive files.
# The 'tar' command originally stood for "tape archive", but you can also use it to archive files to any storage device, not just tapes.

# Check type of tar command
echo "Check type of tar command:"
type -a tar # Output: tar is /usr/bin/tar 

# Read the manual page for the tar command
# echo "Read the manual page for the tar command:"
# man tar

# Syntax: tar [OPTIONS...] [FILE]...
# Options:
# -c, --create: Create a new archive.
# -x, --extract: Extract files from an archive.
# -f, --file=ARCHIVE: Specify the name of the archive file. This option is required when creating or extracting an archive.
# -t, --list: List the contents of an archive.
# -v, --verbose: Display the names of the files being processed.
# -z, --gzip: Compress the archive with gzip.

# Example:
# Three main usage of tar command are:
# tar -cf archive.tar foo bar # Create archive.tar from files foo and bar.
# tar -tvf archive.tar # List all files in archive.tar verbosely.
# tar -xf archive.tar # Extract all files from archive.tar.

# Practice:

# 1. Create a directory and some files in there to demonstrate the tar command.

cd # change to home directory of current user
mkdir catvideos # create a directory called catvideos

# Create some files in the catvideos directory
touch catvideos/cat1.mp4 
touch catvideos/cat2.mp4
touch catvideos/cat3.mp4
touch catvideos/cat4.mp4

# Check the contents of the catvideos directory
ls -l catvideos/
# Output:
# total 0
# -rw-rw-r-- 1 vagrant vagrant 0 22:35  6 Th10 cat1.mp4
# -rw-rw-r-- 1 vagrant vagrant 0 22:35  6 Th10 cat2.mp4
# -rw-rw-r-- 1 vagrant vagrant 0 22:35  6 Th10 cat3.mp4
# -rw-rw-r-- 1 vagrant vagrant 0 22:36  6 Th10 cat4.mp4

# 2. Create an archive of the catvideos directory (not using -v option)

# Create an archive called catvideos.tar from the catvideos directory.
tar -cf catvideos.tar catvideos 

# Check the contents of the current directory
ls -l 
# Output:
# total 16
# drwxrwxr-x 2 vagrant vagrant  4096 22:36  6 Th10 catvideos
# -rw-rw-r-- 1 vagrant vagrant 10240 22:41  6 Th10 catvideos.tar


# List the contents of the catvideos.tar archive.
tar -tf catvideos.tar 
# Output:
# catvideos/
# catvideos/cat4.mp4
# catvideos/cat3.mp4
# catvideos/cat1.mp4
# catvideos/cat2.mp4

# Remove the catvideos.tar archive to clean up.
rm *tar

# 3. Create an archive of the catvideos directory (using -v option)
tar -cvf catvideos.tar catvideos # instead of silently creating the archive, the -v option will display the names of the files being processed.
# Output:
# catvideos/
# catvideos/cat4.mp4
# catvideos/cat3.mp4
# catvideos/cat1.mp4
# catvideos/cat2.mp4

# 3. Restore the catvideos directory from the catvideos.tar archive 

# Create a directory called restore to extract the contents of the catvideos.tar archive into.
mkdir restore 

# Change to the restore directory.
cd restore 

# 3.1 Extract the contents of the catvideos.tar archive into the restore directory. (not using -v option)
tar -xf ../catvideos.tar 

# Check the contents of the restore directory
ls -l catvideos
# Output:
# total 0
# -rw-rw-r-- 1 vagrant vagrant 0 22:35  6 Th10 cat1.mp4
# -rw-rw-r-- 1 vagrant vagrant 0 22:35  6 Th10 cat2.mp4
# -rw-rw-r-- 1 vagrant vagrant 0 22:35  6 Th10 cat3.mp4
# -rw-rw-r-- 1 vagrant vagrant 0 22:36  6 Th10 cat4.mp4

# Remove the catvideos directory to clean up.
rm -rf c*

# Check the contents of the restore directory
ls 
# Output: (none)

# 3.2 Extract the contents of the catvideos.tar archive into the restore directory. (using -v option)
tar -xvf ../catvideos.tar 

# Output:
# catvideos/
# catvideos/cat4.mp4
# catvideos/cat3.mp4
# catvideos/cat1.mp4
# catvideos/cat2.mp4

# Remove the catvideos directory to clean up.
rm -rf cat*

# Change to the home directory of current user.
cd

# 4. Compress and uncompress the archive file using gzip,gunzip command
# One of common things people do with archives is compress them to save space. The gzip command is a popular compression tool that can be used to compress files and archives.

# 4.1 Compress with two step process: first create an archive, then compress it with gzip command.

# 4.1.1 Create an archive called catvideos.tar from the catvideos directory.

# 4.1.1.1 Clean up the catvideos.tar archive if it exists.
rm -rf catvideos.tar

# 4.1.1.2 Create an archive called catvideos.tar from the catvideos directory.
tar -cf catvideos.tar catvideos

# 4.1.2 Compress the catvideos.tar archive using gzip command.
gzip catvideos.tar

# Check the contents of the current directory
ls -l
# Output:
# total 12
# drwxrwxr-x 2 vagrant vagrant 4096 22:36  6 Th10 catvideos
# -rw-rw-r-- 1 vagrant vagrant  199 22:53  6 Th10 catvideos.tar.gz
# drwxrwxr-x 2 vagrant vagrant 4096 23:12  6 Th10 restore

# => gzip command compresses the original file and appends the .gz extension to the name of the compressed file. 
# if you see the name of file has .tar.gz extension, this mean the file is a compressed archive file.

# 4.1.3 Uncompress the catvideos.tar.gz archive using gunzip command.
gunzip catvideos.tar.gz

# Check the contents of the current directory
ls -l
# Output:
# total 20
# drwxrwxr-x 2 vagrant vagrant  4096 22:36  6 Th10 catvideos
# -rw-rw-r-- 1 vagrant vagrant 10240 22:53  6 Th10 catvideos.tar
# drwxrwxr-x 2 vagrant vagrant  4096 23:12  6 Th10 restore

# 4.2 Compress on archive when creating it using -z option of tar command.

# 4.2.1 Create a compressed archive called catvideos.tar.gz from the catvideos directory using -z option of tar command.
tar -zcf catvideos.tar.gz catvideos

# Check the contents of the current directory
ls -l
# Output:
# total 12
# drwxrwxr-x 2 vagrant vagrant 4096 22:36  6 Th10 catvideos
# -rw-rw-r-- 1 vagrant vagrant  185 23:21  6 Th10 catvideos.tar.gz
# drwxrwxr-x 2 vagrant vagrant 4096 23:12  6 Th10 restore

# View the contents of compress archive file using -z and -t option of tar command.
tar -ztf catvideos.tar.gz
# Output:
# catvideos/
# catvideos/cat4.mp4
# catvideos/cat3.mp4
# catvideos/cat1.mp4
# catvideos/cat2.mp4

# Bonus1: Some others use the .tgz extension for compressed archive file instead of the .tar.gz extension. ( This is the same thing, just a different name. )

# Important Note: When you extract a compressed archive file, you need attention where you are extracting it to. If you extract it to a directory that already has files with the same name, those files will be overwritten without warning. 

# Bonus2: '!$' is a special shell variable that expands to the last argument of the previous command. For example, if you run the command 'tar -zcf catvideos.tar.gz catvideos', then '!$' will expand to 'catvideos'. This can be useful for quickly referencing the last argument of a command without having to retype it.

# Bonus3: tar relies on file permissions to determine which files to include in an archive.
# If a user does not have permission to read a file, this user will not be able to include that file in the archive.
# If a user does not have permission to write to a directory, this user will not be able to extract files to that directory.

# Bonus4: That is still supported old syntax of tar command: 
# example: tar zcvf catvideos.tgz catvideos
# rule:
# All option letters must be written together as one cluster, with no spaces between them and no dashes in front.
# The cluster must come immediately after tar and a space; old options can't appear anywhere else.
# Each letter means the same thing as the corresponding short option (e.g. t equals -t).
# When options take arguments, those arguments must appear in the same order as the letters. This gets confusing with several argument-taking options.

# tar -f catvideos.tar -c -v catvideos   # works
# tar cvf catvideos.tar catvideos        # old syntax, works
# tar f catvideos.tar c v                # WRONG: c and v are treated as filenames (operands), not options
#                                        #        -> tar errors because no operation mode (-c/-x/-t) was given

# Recommendation: Use the new syntax of tar command instead of old syntax of tar command because old syntax not flexible and very confusing when using multiple options that take arguments.