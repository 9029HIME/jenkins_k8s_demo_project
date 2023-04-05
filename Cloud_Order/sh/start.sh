#!/bin/bash
CMD=$1
APP_HOME=/home/kjg1/appdata/cloud-order
APP_NAME=Cloud_Order-1.0-SNAPSHOT.jar
LOG_NAME=app.log


case $CMD in
start)
        nohup java -jar -Dfile.encoding=utf-8  $APP_HOME/$APP_NAME  > $APP_HOME/$LOG_NAME &
        echo $! > $APP_HOME/pid
        ;;
stop)
        pid=`cat $APP_HOME/pid`
        kill -9 $pid
        ;;
*)
        echo "Usage: start start | stop | mv .Or use systemctl start | stop | restart | mv  MediaManager.service "
        ;;
esac
