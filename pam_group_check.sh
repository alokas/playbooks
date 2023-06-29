#!/bin/bash

# Step 1: Check if the username is in the /etc/passwd file
cat /etc/passwd | grep $PAM_USER
if [ $? -eq 0 ]; then
    # User is in the password file, exit with a 0 exit code to signify success
    exit 0
fi

# Check if the group name is provided as an argument, otherwise use "linuxlogin"
if [ -z "$1" ]; then
    groupname="linuxlogin"
else
    groupname="$1"
fi

# Clear the cache and check if the user is in the specified group
/sbin/sss_cache -E
/bin/id $PAM_USER | grep -i $groupname

if [ $? -eq 0 ]; then
    # Group exists
    exit 0
else
    exit 1
fi