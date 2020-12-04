#!/bin/bash

gosu sdbadmin /opt/sequoiadb/bin/sdbcmart 

/usr/sbin/sshd -D &

# 'mysql'
gosu sdbadmin /opt/sequoiasql/mysql/bin/sdb_sql_ctl addinst myinst -D /opt/sequoiasql/mysql/database/3306/

gosu sdbadmin /opt/sequoiasql/mysql/bin/mysql -h  127.0.0.1  -P 3306 -u root -e 'set global tx_isolation="read-uncommitted";'
gosu sdbadmin sed -i '/# sequoiadb_use_transaction=ON/a transaction_isolation=READ-UNCOMMITTED'  /opt/sequoiasql/mysql/database/3306/auto.cnf 

# 'sdb'
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /create1copy.js -e "var hs=\"`hostname`\"" 
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate1.js -e "var hs=\"`hostname`\"" &
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate2.js -e "var hs=\"`hostname`\"" &
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /createdate3.js -e "var hs=\"`hostname`\"" &
gosu sdbadmin /opt/sequoiadb/bin/sdb -f /rmtmpcoord.js -e "var hs=\"`hostname`\"" &

gosu sdbadmin sed -i '/# sequoiadb_use_transaction=ON/a transaction_isolation=READ-UNCOMMITTED'  /opt/sequoiasql/mysql/database/3306/auto.cnf 

gosu sdbadmin /opt/sequoiasql/mysql/bin/mysql -h  127.0.0.1  -P 3306 -u root -e 'set global tx_isolation="read-uncommitted";set session tx_isolation='read-uncommitted';'

tail -f /opt/sequoiadb/version.conf
