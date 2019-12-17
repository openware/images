#!/bin/sh
set -e

# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	chown -R node:node /home/node
  ln -fs /home/node/.yarn/bin/ark /usr/bin/ark
  rm -f /home/node/.config/ark-core/$NETWORK/.env
  gosu node sh -c "ark config:publish --network=$NETWORK || echo Configs already present"
	exec gosu node "$0" "$@"
fi

exec "$@"
