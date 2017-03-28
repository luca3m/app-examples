#!/bin/sh
while true; do
  rm fifo 2> /dev/null; 
  mkfifo fifo && echo "Listening on $1" && nc -l $1 <fifo | nc $2 $3 >fifo;
done
