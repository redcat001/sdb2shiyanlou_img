#!/bin/bash
hs=`hostname`

gosu sdbadmin /opt/sequoiadb/bin/sdbcmart

/usr/sbin/sshd -D &


gosu sdbadmin /opt/sequoiadb/bin/sdb -f /create1copy.js -e "var hs=\"`hostname`\""
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate1.js -e "var hs=\"`hostname`\"" &
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate2.js -e "var hs=\"`hostname`\"" &
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate3.js -e "var hs=\"`hostname`\"" &
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /rmtmpcoord.js -e "var hs=\"`hostname`\"" &

tail -f /opt/sequoiadb/version.conf
