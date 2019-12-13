FROM debian:buster

ARG VERSION
ENV GOSU_VERSION 1.11

WORKDIR /root

COPY checksum.sha256 .

RUN apt-get update \
  && apt-get install -y \
     ca-certificates \
     bzip2 \
     gpg \
     dirmngr \ 
     gpg-agent \
     curl \
     wget \
     && curl https://downloads.getmonero.org/cli/monero-linux-x64-v$VERSION.tar.bz2 -O \
     && cat checksum.sha256 | grep ${VERSION} | sha256sum -c  \
     && tar -xvf monero-linux-x64-v$VERSION.tar.bz2 \
     && rm monero-linux-x64-v$VERSION.tar.bz2 \
     && cp ./monero-x86_64-linux-gnu-v$VERSION/monerod . \
     && cp ./monero-x86_64-linux-gnu-v$VERSION/monero-wallet-rpc .

RUN set -x \
  && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  && export GNUPGHOME="$(mktemp -d)" \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
  && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
  && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu \
  && gosu nobody true

RUN useradd -ms /bin/bash monero && mkdir -p /home/monero/.bitmonero
RUN mv /root/monerod /home/monero/monerod \
  && mv /root/monero-wallet-rpc /home/monero/monero-wallet-rpc \
  && chown -R monero:monero /home/monero

USER monero
WORKDIR /home/monero

# blockchain location
VOLUME /home/monero/.bitmonero

EXPOSE 18080 18081 28080 28081 38080 38081

COPY scripts/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
