#!/bin/bash
LIB_VERSION=2.0.20-stable
FASTDFS_VERSION=v3.11
wget --no-check-certificate https://github.com/downloads/libevent/libevent/libevent-$LIB_VERSION.tar.gz
tar zxvf libevent-$LIB_VERSION.tar.gz
cd libevent-$LIB_VERSION
./configure
make
make install
ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib64/libevent-2.0.so.5
cd ..
wget http://fastdfs.googlecode.com/files/FastDFS_$FASTDFS_VERSION.tar.gz
tar zxvf FastDFS_$FASTDFS_VERSION.tar.gz
cd FastDFS
sed -i 's/#WITH_HTTPD=1/WITH_HTTPD=1/g;s/#WITH_LINUX_SERVICE=1/WITH_LINUX_SERVICE=1/g' make.sh
./make.sh
./make.sh install
