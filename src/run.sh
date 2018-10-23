#!/bin/bash

/root/cleanup.sh
/root/add-users.py

echo "Starting sshd..."
exec /usr/sbin/sshd -D
