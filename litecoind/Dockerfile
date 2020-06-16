FROM debian:buster

ARG VERSION

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

ENV GOSU_VERSION=1.7

RUN useradd -r litecoin \
  && apt-get update -y \
  && apt-get install -y curl htop procps \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && curl -o /usr/local/bin/gosu -L https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
	&& chmod +x /usr/local/bin/gosu

ENV LITECOIN_VERSION=0.17.1 \
  LITECOIN_DATA=/home/litecoin/.litecoin

ENV LITECOINT_ARCHIVE_FILE=litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz

RUN \
  curl -O https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/${LITECOINT_ARCHIVE_FILE} \
  && tar --strip=2 -xzf ${LITECOINT_ARCHIVE_FILE} -C /usr/local/bin \
  && rm ${LITECOINT_ARCHIVE_FILE}

EXPOSE 9332 9333 19332 19333 19444

VOLUME ["/home/litecoin/.litecoin"]

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["litecoind"]
