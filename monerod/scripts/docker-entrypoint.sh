#!/bin/sh
set -e
# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	chown -R monero .
	exec gosu monero "$0" "$@"
fi

exec "$@"

