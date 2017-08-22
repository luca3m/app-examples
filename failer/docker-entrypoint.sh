#!/bin/sh
set -x
sleep 5
touch /healthy
sleep 60
rm /healthy
while true; do
  sleep 10
done
