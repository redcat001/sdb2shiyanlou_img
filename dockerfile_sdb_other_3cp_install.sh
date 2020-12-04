#!/bin/bash
hs=`hostname`

gosu sdbadmin /opt/sequoiadb/bin/sdbcmart

#mysql
if [ ! -d "/opt/sequoiasql/mysql/database/3306/" ];then
   gosu sdbadmin /opt/sequoiasql/mysql/bin/sdb_sql_ctl addinst myinst -D /opt/sequoiasql/mysql/database/3306/ 
else
   chown sdbadmin:sdbadmin_group -R /opt/sequoiasql/mysql/database/3306/
   gosu sdbadmin /opt/sequoiasql/mysql/bin/sdb_sql_ctl start  myinst
fi

gosu sdbadmin /opt/sequoiasql/mysql/bin/mysql -h  127.0.0.1  -P 3306 -u root -e 'set global tx_isolation="read-uncommitted";'
gosu sdbadmin sed -i '/# sequoiadb_use_transaction=ON/a transaction_isolation=READ-UNCOMMITTED'  /opt/sequoiasql/mysql/database/3306/auto.cnf 


/usr/sbin/sshd -D &

#sdb
if [ ! -d "/opt/sequoiadb/database/coord" ];then
   gosu sdbadmin /opt/sequoiadb/bin/sdb -f /create3copy.js -e "var hs=\"`hostname`\""
else
   gosu sdbadmin /opt/sequoiadb/bin/sdbstart -t all
fi


#spark
if [ ! -d "/home/sdbadmin/.ssh/" ];then
   gosu sdbadmin /ssh.sh `hostname`
fi

/opt/sequoiasql/mysql/bin/mysql  -S /opt/sequoiasql/mysql/database/3306/mysqld.sock -u root < /mysql.sql


gosu sdbadmin /opt/spark/sbin/start-all.sh
sleep 5
gosu sdbadmin /opt/spark/sbin/start-thriftserver.sh --master spark://${hs}:7077  --executor-cores 1    --total-executor-cores 2 --executor-memory 512m

gosu sdbadmin /opt/sequoiasql/mysql/bin/mysql -h  127.0.0.1  -P 3306 -u root -e 'set global tx_isolation="read-uncommitted";set session tx_isolation='read-uncommitted';'
gosu sdbadmin sed -i '/# sequoiadb_use_transaction=ON/a transaction_isolation=READ-UNCOMMITTED'  /opt/sequoiasql/mysql/database/3306/auto.cnf 

tail -f /opt/sequoiadb/version.conf
