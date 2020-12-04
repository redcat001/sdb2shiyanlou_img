#!/bin/bash

/usr/sbin/sshd -D &

/usr/sbin/cron start

tail -f /opt/sequoiasql/mysql/version.info 

