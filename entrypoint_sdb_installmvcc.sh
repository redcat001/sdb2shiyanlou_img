#!/bin/bash

gosu sdbadmin /opt/sequoiadb/bin/sdbcmart

/usr/sbin/sshd -D &

#sdb
if [ ! -d "/opt/sequoiadb/database/coord" ];then
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /create1copymvcc.js -e "var hs=\"`hostname`\"" 
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate1mvcc.js -e "var hs=\"`hostname`\"" &
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate2mvcc.js -e "var hs=\"`hostname`\"" &
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate3mvcc.js -e "var hs=\"`hostname`\"" &
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /rmtmpcoord.js -e "var hs=\"`hostname`\"" &
else
   gosu sdbadmin /opt/sequoiadb/bin/sdbstart -t all &
fi
gosu sdbadmin /opt/sequoiadb/bin/stp --daemon
export TERMINFO=/lib/terminfo/

tail -f /opt/sequoiadb/version.conf
