#!/bin/sh

if [ -n "$GRON_AWKLIBPATH" ]
then
   export AWKLIBPATH="$GRON_AWKLIBPATH"
fi

exec $AWK "$@"