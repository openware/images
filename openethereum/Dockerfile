FROM rust:1.47 AS builder

ARG VERSION

RUN apt-get update && apt-get install -y git curl wget pwgen vim htop gcc g++ cmake

RUN git clone https://github.com/openethereum/openethereum --branch=release/v${VERSION} \ 
  && cd openethereum \
  && cargo build --features secretstore --release \
  && cp ./target/release/openethereum /openethereum

FROM debian:buster

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# Show backtraces
ENV RUST_BACKTRACE 1

RUN groupadd -g ${GROUP_ID} parity \
	&& useradd -u ${USER_ID} -g parity -s /bin/bash -m -d /parity parity

RUN apt-get update && apt-get -y upgrade && apt-get install -y wget ca-certificates gpg \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY --from=builder /openethereum/target/release/openethereum /usr/bin

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

VOLUME ["/parity"]
EXPOSE 5001 8080 8082 8083 8545 8546 8180 30303/tcp 30303/udp

WORKDIR /parity

COPY scripts/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
