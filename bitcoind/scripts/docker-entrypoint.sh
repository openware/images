#!/bin/sh
set -e
# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	chown -R bitcoin .
	exec gosu bitcoin "$0" "$@"
fi

exec "$@"

