#!/bin/bash

process="$1"
operation="$2"


function start_process()
{
  cd %OPENAIRCN_SCRIPTS%
  screen -wipe >/dev/null
  screen -S $process -d -m -h 10000 ./run_$process
}

function stop_process()
{
  cd %OPENAIRCN_SCRIPTS%
  ./run_$process -k
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

