#!/bin/bash

/root/cleanup.sh
/root/add-users.sh

echo "Starting sshd..."
exec /usr/sbin/sshd -D
