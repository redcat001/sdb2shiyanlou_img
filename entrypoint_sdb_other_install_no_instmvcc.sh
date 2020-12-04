#!/bin/bash
hs=`hostname`

gosu sdbadmin /opt/sequoiadb/bin/sdbcmart

/usr/sbin/sshd -D &


gosu sdbadmin /opt/sequoiadb/bin/sdb -f /create1copymvcc.js -e "var hs=\"`hostname`\""
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate1mvcc.js -e "var hs=\"`hostname`\"" &
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate2mvcc.js -e "var hs=\"`hostname`\"" &
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate3mvcc.js -e "var hs=\"`hostname`\"" &
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /rmtmpcoord.js -e "var hs=\"`hostname`\"" &

gosu sdbadmin /opt/sequoiadb/bin/stp --daemon

tail -f /opt/sequoiadb/version.conf
