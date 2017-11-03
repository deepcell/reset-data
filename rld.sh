#!/bin/sh

# set current date [START]
NOW="$(date +'%d-%m-%Y:%H:%M:%S')"

# set transaction
TRANSACTION="BEGIN;TRUNCATE TABLE table_test;TRUNCATE TABLE table_test_two; \
TRUNCATE TABLE table_test_three;COMMIT;"

# set database credentials
DB_USER="user"
DB_PASS="passwd"
DB_NAME="database"
HOSTNAME="localhost"

# backup before truncate tables
echo " "
echo "WARNING: starting backup at $NOW, please wait.."
echo " .. " | mysqldump -u"$DB_USER" -p"$DB_PASS" -h "$HOSTNAME" "$DB_NAME" | gzip -9 > "backup_$NOW.sql.gz"
echo "WARNING: backup done at $NOW"

# truncate tables here
echo "WARNING: starting sql transaction at $NOW, please wait.."
echo "$TRANSACTION" | mysql -u"$DB_USER" -p"$DB_PASS" -D"$DB_NAME"
echo " "
echo "WARNING: a transaction with the following query: \n $TRANSACTION \n \
was executed with the data base: >$DB_NAME< at $NOW"
echo "WARNING: your local data was reset [truncated]."

# set current date [END]
END="$(date +'%d-%m-%Y:%H:%M:%S')"

echo " "
echo "+----------------------------+"
echo "|  start $NOW |"
echo "|  end   $END |"
echo "+----------------------------+"
echo " "
