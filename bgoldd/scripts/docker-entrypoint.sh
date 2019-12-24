#!/bin/sh
set -e
# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	chown -R bitcoingold .
	exec gosu bitcoingold "$0" "$@"
fi

exec "$@"

