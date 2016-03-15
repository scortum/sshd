#!/bin/bash

/root/add-users.sh

exec /usr/sbin/sshd -D

