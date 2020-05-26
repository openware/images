#!/bin/bash
set -e

# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	chown -R bitcoincash .
	exec gosu bitcoincash "$0" "$@"
fi

exec "$@"