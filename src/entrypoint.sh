#!/bin/bash

rm -rf /.dockerenv    2>/dev/null
rm /run/sshd.pid      2>/dev/null
rm /run/rsyslogd.pid  2>/dev/null

/root/add-user.sh
/root/add-users.py

touch /var/log/auth.log
touch /var/log/syslog

echo "Starting everything..."
# FIX LATER: Logging is currently commented out, as this does not work anyway.
#exec /root/ubik name=syslog   /usr/sbin/rsyslogd -n                       \
#      ---       name=sshd     /usr/sbin/sshd -D                           \
#      ---       name=logtail  pause=5  /usr/bin/tail -f /var/log/syslog   \
#      ---       name=authlog  pause=5  /usr/bin/tail -f /var/log/auth.log


exec /tini -- /usr/sbin/sshd -D

