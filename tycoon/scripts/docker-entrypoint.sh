#!/bin/sh
set -e

# allow the container to be started with `--user`
if [ "$(id -u)" = '0' ]; then
	chown -R node:node /home/node
  ln -fs /home/node/core/packages/core/bin/run /usr/bin/ark
  gosu node sh -c "ark config:publish --network=$NETWORK || echo Configs already present"
  rm -rf /home/node/.config/tycoon-core/$NETWORK/.env
	exec gosu node "$0" "$@"
fi

exec "$@"
