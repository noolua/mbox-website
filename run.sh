#!/bin/sh
VAR_PATH=/home/hscdn/mbox-website/var
NGX_BIN=/home/hscdn/usr/local/openresty/nginx/sbin/nginx

case $1 in
  start)
    $NGX_BIN -p $VAR_PATH -c conf/nginx.conf
    ;;
  stop)
    $NGX_BIN -p $VAR_PATH -c conf/nginx.conf -s stop
    ;;
  reload)
    $NGX_BIN -p $VAR_PATH -c conf/nginx.conf -s reload
    ;;
  *)
    echo "usage: $0 start | stop | reload"
    ;;
esac
