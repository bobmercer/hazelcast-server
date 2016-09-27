#!/bin/sh
set -e

if [[ "$1" == "hz-node" ]] ; then
    echo "Starting process manager..."
    exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
fi
 
exec "$@"