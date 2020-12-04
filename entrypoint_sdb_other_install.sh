#!/bin/bash
hs=`hostname`

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
   gosu sdbadmin /opt/sequoiadb/bin/sdbstart -t all
fi


#mysql
if [ ! -d "/opt/sequoiasql/mysql/database/3306/" ];then
   gosu sdbadmin /opt/sequoiasql/mysql/bin/sdb_sql_ctl addinst myinst -D /opt/sequoiasql/mysql/database/3306/ 
   /opt/sequoiasql/mysql/bin/mysql  -S /opt/sequoiasql/mysql/database/3306/mysqld.sock -u root < /mysql.sql
else
   chown sdbadmin:sdbadmin_group -R /opt/sequoiasql/mysql/database/3306/
   gosu sdbadmin /opt/sequoiasql/mysql/bin/sdb_sql_ctl start  myinst
fi

gosu sdbadmin /opt/sequoiasql/mysql/bin/mysql -h  127.0.0.1  -P 3306 -u root -e 'set global tx_isolation="read-uncommitted";'
gosu sdbadmin sed -i '/# sequoiadb_use_transaction=ON/a transaction_isolation=READ-UNCOMMITTED'  /opt/sequoiasql/mysql/database/3306/auto.cnf 



#pg
if [ ! -d "/opt/sequoiasql/postgresql/database/5432/" ];then
   export PATH="/opt/sequoiasql/postgresql/bin:$PATH"
   export LD_LIBRARY_PATH="/opt/sequoiasql/postgresql/lib:$LD_LIBRARY_PATH"
   gosu sdbadmin /opt/sequoiasql/postgresql/bin/sdb_sql_ctl addinst myinst -D /opt/sequoiasql/postgresql/database/5432/ 
   gosu sdbadmin /opt/sequoiasql/postgresql/bin/sdb_sql_ctl start myinst
#   gosu sdbadmin /opt/sequoiasql/postgresql/bin/sdb_sql_ctl createdb company myinst
#   gosu sdbadmin /opt/sequoiasql/postgresql/bin/psql -p 5432 company < /postgresql.sql
else
  gosu sdbadmin /opt/sequoiasql/postgresql/bin/sdb_sql_ctl start myinst
fi


gosu sdbadmin /opt/sequoiasql/mysql/bin/mysql -h  127.0.0.1  -P 3306 -u root -e 'set global tx_isolation="read-uncommitted";'
gosu sdbadmin sed -i '/# sequoiadb_use_transaction=ON/a transaction_isolation=READ-UNCOMMITTED'  /opt/sequoiasql/mysql/database/3306/auto.cnf 


#spark
if [ ! -d "/home/sdbadmin/.ssh/" ];then
   gosu sdbadmin /ssh.sh `hostname`
fi

gosu sdbadmin /opt/spark/sbin/start-all.sh
sleep 5
gosu sdbadmin /opt/spark/sbin/start-thriftserver.sh --master spark://${hs}:7077  --executor-cores 1    --total-executor-cores 2 --executor-memory 1g

gosu sdbadmin /opt/sequoiasql/mysql/bin/mysql -h  127.0.0.1  -P 3306 -u root -e 'set global tx_isolation="read-uncommitted";set session tx_isolation='read-uncommitted';'
gosu sdbadmin sed -i '/# sequoiadb_use_transaction=ON/a transaction_isolation=READ-UNCOMMITTED'  /opt/sequoiasql/mysql/database/3306/auto.cnf 

tail -f /opt/sequoiadb/version.conf
