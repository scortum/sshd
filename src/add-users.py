#!/usr/bin/env python3

from pathlib import Path
import sh


dir_list = [x for x in Path('/home').iterdir() if x.is_dir()]

for dir in dir_list:
  user = dir.name
  
  try:
    sh.id(user)
  except sh.ErrorReturnCode_1:
    stats = dir.stat()
    uid = stats.st_uid
    gid = stats.st_gid

    print("creating user {} ({}:{})".format(user, uid, gid))

    sh.adduser('--uid', uid, '--gid', gid,
               '--shell', '/bin/bash',
               '--no-create-home',
               '--disabled-password',
               '--gecos', '""',
               user)
