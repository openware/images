#!/usr/bin/env bash

function isUp {

  PS=$(docker inspect --format="{{ .Name }}" $(docker ps -q --no-trunc) | sed "s,/,,g")

  IS=not-running

  for c in $PS
  do
    if [[ "$c" == "$1" ]]; then
      IS=running
    fi
  done

  if [[ $IS == "not-running" ]]; then

    PSA=$(docker inspect --format="{{ .Name }}" $(docker ps -aq --no-trunc) | sed "s,/,,g")
    for c in $PSA
    do
      if [[ "$c" == "$1" ]]; then
        IS=stopped
      fi
    done
  fi

  echo $IS
}

images=(
"tron-private"
"tron-events"
"tron-proxy"
"tron-redis"
"tron-postgres"
)

for image in "${images[@]}"
do
  echo $(isUp $image)
  if [[ $(isUp $image) != "not-running" ]]; then
    docker rm -f $image
  fi
done

docker-compose up