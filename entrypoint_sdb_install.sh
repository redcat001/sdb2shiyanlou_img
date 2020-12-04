#!/bin/bash

gosu sdbadmin /opt/sequoiadb/bin/sdbcmart

/usr/sbin/sshd -D &

#sdb
if [ ! -d "/opt/sequoiadb/database/coord" ];then
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /create1copy.js -e "var hs=\"`hostname`\"" 
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate1.js -e "var hs=\"`hostname`\"" &
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate2.js -e "var hs=\"`hostname`\"" &
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate3.js -e "var hs=\"`hostname`\"" &
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /rmtmpcoord.js -e "var hs=\"`hostname`\"" &
else
   gosu sdbadmin /opt/sequoiadb/bin/sdbstart -t all &
fi

export TERMINFO=/lib/terminfo/

tail -f /opt/sequoiadb/version.conf
