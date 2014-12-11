#!/bin/bash
#Author:arezone
#Website: http://www.olinux.org.cn
MYSQL=/usr/local/webserver/mysql/bin/mysql
DBDIR=/data/mysql
BACKDIR=/data/bak/mysql
TIME=`date -d "today" +%F`
if [ -d $BACKDIR ]
then
        echo "OK!"
else
        mkdir -p $BACKDIR
fi
cd $DBDIR
cp -p $DBDIR/relay-log.info $DBDIR/test/
DB=$(ls -p | grep / |tr -d / | grep -Ev 'information_schema|performance_schema|test')
/etc/init.d/mysqld stop
for i in $DB
do
tar czf $BACKDIR/$i\_db\_$TIME.tar.gz $i
done
/etc/init.d/mysqld start
find $BACKDIR -name "*.tar.gz" -type f -mtime +15 -exec rm {} \;  >/dev/null 2>&1