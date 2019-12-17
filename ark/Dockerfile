FROM node:12-buster

ARG VERSION

WORKDIR /home/node/core

RUN apt-get update && apt-get -y upgrade && apt-get install -y ca-certificates make gcc g++ python git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm i -g --loglevel notice pm2

ENV GOSU_VERSION 1.11
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

# VOLUME ["/ark"]
EXPOSE 4002 4003 4040 8080

USER node

RUN yarn global add @arkecosystem/core@${VERSION} \
  && yarn global add @arkecosystem/exchange-json-rpc-cli \
  && yarn cache clean

COPY scripts/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
