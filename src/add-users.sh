#!/bin/bash

cd /home
ls -dln * | awk '{print $3":"$4":"$9}' | while read in; 
do
  uid=$(echo "$in" | cut -f 1 -d ":")
  gid=$(echo "$in" | cut -f 2 -d ":")
  user=$(echo "$in" | cut -f 3 -d ":")

  id $user
  if [ $? -ne 0 ]; then
    echo "add user $user ($uid/$gid)"
    adduser --shell /bin/bash  \
            --uid $uid  \
            --gid $gid  \
            --no-create-home  \
            --disabled-password  \
            --gecos "" \
            $user
  fi
done


