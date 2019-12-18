#!/bin/sh
set -e
# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	chown -R geth .
	exec gosu geth "$0" "$@"
fi

exec "$@"
