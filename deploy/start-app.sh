nohup java -jar app.jar > log.txt 2> errors.txt < /dev/null &
PID=$!
echo $PID > pid.txt
