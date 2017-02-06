#!/bin/sh

set -e

if [ "${SCHEDULE}" = "" ]; then
  sh main.sh
else
  exec go-cron "$SCHEDULE" /bin/sh main.sh
fi
