#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo 'You need to set an user as argument! 
    Example : `./generate_user_sql.sh hive`'
    exit 0
fi

user_mysql=$1

echo "CREATE USER '$user_mysql'@'localhost' IDENTIFIED BY '$user_mysql';
GRANT ALL PRIVILEGES ON *.* TO '$user_mysql'@'localhost';
CREATE USER '$user_mysql'@'%' IDENTIFIED BY '$user_mysql';
GRANT ALL PRIVILEGES ON *.* TO '$user_mysql'@'%';
GRANT ALL PRIVILEGES ON *.* TO '$user_mysql'@'localhost' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON *.* TO '$user_mysql'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;"
