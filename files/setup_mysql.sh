#!/bin/bash

if [ -f /.mysql_admin_created ]; then
	echo "MySQL 'admin' user already created!"
	exit 0
fi

if [ -f /data/mysql/ibdata1 ]; then
	echo "MySQL database already created!"
	exit 0
fi


echo "=> Initializing empty database"
mysql_install_db > /dev/null 2>&1

echo "=> Starting mysql"
/usr/bin/mysqld_safe > /dev/null 2>&1 &
sleep 3s


PASS=$(pwgen -s 12 1)
echo "=> Creating MySQL admin user with random password"
RET=1
while [[ RET -ne 0 ]]; do
	sleep 5
	mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
	RET=$?
done

echo "=> Granting privileges"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"

echo "=> Stoping mysql"
killall mysqld

echo "=> Done!"
touch /.mysql_admin_created

echo "========================================================================"
echo ""
echo "    mysql -uadmin -p$PASS -h<host> -P<port>"
echo ""
echo "MySQL user 'root' has no password but only allows local connections"
echo ""
echo "========================================================================"
