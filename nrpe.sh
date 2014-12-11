#!/bin/bash
/usr/sbin/useradd nagios
echo "5+hter64!" | passwd --stdin nagios
wget http://nagios-plugins.org/download/nagios-plugins-2.0.2.tar.gz
wget http://downloads.sourceforge.net/project/nagios/nrpe-2.x/nrpe-2.15/nrpe-2.15.tar.gz
tar xzf nagios-plugins-2.0.2.tar.gz
cd nagios-plugins-2.0.2
./configure --prefix=/usr/local/nagios
make && make install
chown nagios.nagios /usr/local/nagios/
chown -R nagios.nagios /usr/local/nagios/libexec/
cd ../
tar xzf nrpe-2.15.tar.gz
cd nrpe-2.15
./configure
make all
make install-plugin
make install-daemon
make install-daemon-config

sed -i 's#allowed_hosts=127.0.0.1#allowed_hosts=127.0.0.1,192.168.10.181#g' /usr/local/nagios/etc/nrpe.cfg 
/usr/local/nagios/bin/nrpe -c /usr/local/nagios/etc/nrpe.cfg -d