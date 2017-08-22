#!/bin/sh
set -x
sleep 5
touch /healthy
sleep 60
rm /healthy
# hang
tail -f /dev/null
