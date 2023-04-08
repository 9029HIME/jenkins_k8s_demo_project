#!/bin/bash
APP_NAME=Cloud_Order-1.0-SNAPSHOT.jar
APP_LOG=order.log
APP_HOME=/home/kjg1/jenkins_output/Cloud_Order/target
pid=`ps -ef | grep ${APP_NAME} | grep -v grep | awk '{print $2}'`

# 判断Cloud-Order是否运行中，存在：返回1，不存在：返回0
exist() {
  if [ -z "${pid}" ]
  then
        return 0
  else
        return 1
  fi
}


stop() {
        exist
        if [ $? -eq "1" ]; then
                kill ${pid}
                rm -f $APP_HOME/$APP_LOG
        else
                echo "not running"
        fi
}

start(){
        nohup /usr/local/jdk/jdk1.8.0_311/bin/java -jar -Dfile.encoding=utf-8 $APP_HOME/$APP_NAME  > $APP_HOME/$APP_LOG 2>&1 &
}


restart(){
        stop
        start
}

restart
