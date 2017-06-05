#!/bin/sh
SERVICE_NAME=petclinic
PATH_TO_JAR=/home/cloud-user/petclinic/app.jar
PID_PATH_NAME=/home/cloud-user/petclinic/pid.txt

echo "Starting $SERVICE_NAME ..."
  if [ ! -f $PID_PATH_NAME ]; then
    nohup java -jar $PATH_TO_JAR /tmp 2>> /dev/null >> /dev/null &
    echo $! > $PID_PATH_NAME
    echo "$SERVICE_NAME started ..."
 else
    echo "$SERVICE_NAME is already running ..."
 fi
