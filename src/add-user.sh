#!/bin/bash

mkdir -p /root/.ssh
# Translate semicola in $SSH_KEY into newlines, wiping spaces behind'
echo ${SSH_KEY} | sed -e 's,;\s*,\
,g'> /root/.ssh/authorized_keys

chmod 700 ~/.ssh/ && chmod 600 ~/.ssh/*
