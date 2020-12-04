
UPDATE mysql.user SET host='%' WHERE user='root';
CREATE USER 'metauser'@'%' IDENTIFIED BY 'metauser';
GRANT ALL ON *.* TO 'metauser'@'%';
CREATE DATABASE metastore CHARACTER SET 'latin1' COLLATE 'latin1_bin';
FLUSH PRIVILEGES;
