#!/bin/sh
set -e
# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	chown -R parity:parity /parity
	exec gosu parity "$0" "$@"
fi

exec "$@"
