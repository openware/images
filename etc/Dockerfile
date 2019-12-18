FROM debian:buster

ARG VERSION

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN groupadd -g ${GROUP_ID} geth \
	&& useradd -u ${USER_ID} -g geth -s /bin/bash -m -d /geth geth

RUN apt-get update && apt-get -y upgrade && apt-get install -y wget ca-certificates gpg unzip\
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY checksum.sha256 /root

RUN cd /root \
  && wget -O multi-geth-$VERSION.zip https://github.com/multi-geth/multi-geth/releases/download/$VERSION/multi-geth-alltools-linux.zip \
  && cat checksum.sha256 | grep ${VERSION} | sha256sum -c \
     && unzip -d multi-geth-$VERSION multi-geth-$VERSION.zip  \
     && rm multi-geth-$VERSION.zip \
     && cp ./multi-geth-$VERSION/geth . \
  && mv geth /usr/bin/geth

ENV GOSU_VERSION 1.11
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

VOLUME ["/geth"]
EXPOSE 8545 8546 8547 30303 30303/udp

WORKDIR /geth

COPY scripts/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
