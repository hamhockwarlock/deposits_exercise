#!/bin/sh

set -e

if [ -f tmp/pds/server.pid ]; then
  rm tmp/pids/server.pid
fi

exec "$@"
