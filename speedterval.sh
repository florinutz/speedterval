#!/bin/bash

wrapped_cmd=speedtest

command -v $wrapped_cmd >/dev/null 2>&1 || {
  echo >&2 "Please install $wrapped_cmd:"
  echo >&2 "  https://www.speedtest.net/apps/cli"
  echo >&2 "  on ubuntu: apt install speedtest-cli"
  exit 1
}

usage() {
   echo "Check download speed periodically"
   echo
   echo "Syntax: speedterval.sh [-c|t|l|h]"
   echo "options:"
   echo "  -c <int>     Specifies the number of tests that should be performed. Default infinite."
   echo "  -t <time>     Delay between tests, in the format accepted by the sleep command. Defaults to $time."
   echo "  -l <logPath>  Path to log results to. Default /dev/null"
   echo "  -h            Print usage"
}

# setting some defaults
count=-1
time=1m
log=/dev/null

# overriding the defaults if incoming cli flags require it
while getopts "hc:t:l:" opt; do
   case $opt in
      h) usage; exit 0;;
      c) count=$OPTARG;;
      t) time=$OPTARG;;
      l) log=$OPTARG;;
      *)
   esac
done

# the loop
while [ "$count" -gt 0 ] || [ "$count" -lt 0 ]; do
  speedtest --single --no-upload --simple | awk 'NR==2 {print strftime("%H:%M:%S") " " $2}' | tee -a "$log"
  ((count--))
  [ "$count" -gt 0 ] && sleep "$time"
done
