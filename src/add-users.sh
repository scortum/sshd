#!/bin/bash

cat credentials | while read in; 
do
  user=$in | cut -f 1 -d ":"
  echo adduser $user 
  adduser $user
  echo "$in" | chpasswd
done


