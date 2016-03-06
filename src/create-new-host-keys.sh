#!/bin/bash

# from http://www.cyberciti.biz/faq/howto-regenerate-openssh-host-keys/
/bin/rm -v /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server

