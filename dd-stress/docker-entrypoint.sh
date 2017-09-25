#!/bin/sh
COUNT=${1:-9M}
while true; do
  time dd if=/dev/zero of=/dev/null count=$COUNT
done
