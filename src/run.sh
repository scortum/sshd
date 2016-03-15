#!/bin/bash

/root/cleanup.sh
/root/add-users.sh
exec /usr/sbin/sshd -D

