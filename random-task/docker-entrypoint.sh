#!/bin/sh
set -x
sleep $(( $RANDOM / 7000 ))
exit $(( $RANDOM % 3 ))
