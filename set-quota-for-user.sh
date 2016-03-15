#!/bin/bash

user=1002

setquota -u -F vfsv0 ${user}  2097152 2097152 1000000 1000000 /

## or use edquota to edit the quota
