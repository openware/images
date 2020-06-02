FROM debian:buster

ARG VERSION

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN groupadd -g ${GROUP_ID} bitcoin \
	&& useradd -u ${USER_ID} -g bitcoin -s /bin/bash -m -d /bitcoin bitcoin

RUN apt-get update && apt-get -y upgrade && apt-get install -y wget ca-certificates gpg && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY checksum.sha256 /root

RUN set -x && \
	cd /root && \
    wget -q https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz && \
	cat checksum.sha256 | grep ${VERSION} | sha256sum -c  && \
    tar xvf bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz && \
    cd bitcoin-${VERSION} && \
    mv bin/* /usr/bin/ && \
    mv lib/* /usr/bin/ && \
    mv include/* /usr/bin/ && \
    mv share/* /usr/bin/ && \
    cd /root && \
    rm -Rf bitcoin-${VERSION} bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz

ENV GOSU_VERSION 1.7
RUN set -x \
	&& apt-get install -y --no-install-recommends \
		ca-certificates \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true 


VOLUME ["/bitcoin"]
EXPOSE 8332 8333 18332 18333

WORKDIR /bitcoin

COPY scripts/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]