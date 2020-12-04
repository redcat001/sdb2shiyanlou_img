create extension sdb_fdw;
create server sdb_server foreign data wrapper sdb_fdw options(address '127.0.0.1', service '11810', user 'sdbUserName', password 'sdbPassword', preferedinstance 'A', transaction 'on');
