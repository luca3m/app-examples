#!/bin/sh
set -x
AUTOFAILRATIO=10
if [ ! -z $1 ]; then
  AUTOFAILRATIO=$1
fi
sleep 5
touch /healthy
while true; do
  if [ -e /fail ]; then
    exit 1
  elif [ -e /failcheck ]; then
    rm /healthy
  elif [ $(( $RANDOM % $AUTOFAILRATIO )) == 0 ]; then
    rm /healthy
  elif [ $(( $RANDOM % $AUTOFAILRATIO )) == 0 ]; then
    touch /healthy
  fi
  sleep 1
done
