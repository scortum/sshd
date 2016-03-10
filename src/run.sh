#!/bin/bash

/add-users.sh

exec /usr/sbin/sshd -D

