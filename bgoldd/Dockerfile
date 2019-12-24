FROM debian:buster

ARG VERSION

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN groupadd -g ${GROUP_ID} bitcoingold \
	&& useradd -u ${USER_ID} -g bitcoingold -s /bin/bash -m -d /bitcoingold bitcoingold

RUN apt-get update && apt-get -y upgrade && apt-get install -y wget ca-certificates gpg gpg-agent  && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY checksum.sha256 /root

RUN cd /root && \
    wget -q https://github.com/BTCGPU/BTCGPU/releases/download/v0.15.2/bitcoin-gold-0.15.2-x86_64-linux-gnu.tar.gz && \
	cat checksum.sha256 | grep ${VERSION} | sha256sum -c  &&\
    tar xvf bitcoin-gold-${VERSION}-x86_64-linux-gnu.tar.gz && \
    cd bitcoin-gold-${VERSION} && \
    mv bin/* /usr/bin/ && \
    mv lib/* /usr/bin/ && \
    mv include/* /usr/bin/ && \
    mv share/* /usr/bin/ && \
    cd /root && \
    rm -Rf bitcoin-gold-${VERSION} bitcoin-gold-${VERSION}-x86_64-linux-gnu.tar.gz

ENV GOSU_VERSION 1.11
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


VOLUME ["/bitcoingold"]
EXPOSE 8332 8333 18332 18333

WORKDIR /bitcoingold

COPY scripts/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
