#!/bin/bash

process="$1"
operation="$2"


function start_process()
{
  cd /root/openair-cn/SCRIPTS
  screen -wipe >/dev/null
  screen -S $process -d -m -h 10000 ./run_$process
}

function stop_process()
{
  cd /root/openair-cn/SCRIPTS
  ./run_$process -k
#  screen -S $process -X quit
#  ps fax|grep "run_$process" | awk '{}{printf "Stopping PID %s\n",$1; system("kill -KILL " $1 " >/dev/null");}'
  screen -wipe >/dev/null
}


case $operation in
  "start")
    start_process
    ;;
  "stop")
    stop_process
    ;;
  "restart")
    stop_process
    start_process
    ;;
  *)
    echo "unrecognized operation"
    exit -1
    ;;
esac

