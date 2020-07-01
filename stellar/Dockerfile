FROM debian:stretch

ENV STELLAR_CORE_VERSION 13.2.0-1260-e45018ea
ENV HORIZON_VERSION 1.5.0

EXPOSE 5432
EXPOSE 8000
EXPOSE 11625
EXPOSE 11626

RUN apt-get update \
  && apt-get install -y wget curl git libpq-dev libsqlite3-dev libsasl2-dev postgresql-client sudo vim zlib1g-dev jq netcat \
  && apt-get clean

# stellar-core
RUN wget -O stellar-core.deb https://s3.amazonaws.com/stellar.org/releases/stellar-core/stellar-core-${STELLAR_CORE_VERSION}_amd64.deb \
  && dpkg -i stellar-core.deb \
  && rm stellar-core.deb

# horizon
RUN wget -O horizon.tar.gz https://github.com/stellar/go/releases/download/horizon-v${HORIZON_VERSION}/horizon-v${HORIZON_VERSION}-linux-amd64.tar.gz \
  && tar -zxvf horizon.tar.gz \
  && mv /horizon-v${HORIZON_VERSION}-linux-amd64/horizon /usr/local/bin \
  && chmod +x /usr/local/bin/horizon \
  && rm -rf horizon.tar.gz /horizon-v${HORIZON_VERSION}-linux-amd64

RUN ["mkdir", "-p", "/opt/stellar"]

RUN useradd --uid 10011001 --home-dir /home/stellar --no-log-init stellar \
    && mkdir -p /home/stellar \
    && chown -R stellar:stellar /home/stellar

RUN ["ln", "-s", "/opt/stellar", "/stellar"]
RUN ["ln", "-s", "/opt/stellar/core/etc/stellar-core.cfg", "/stellar-core.cfg"]
# RUN ["ln", "-s", "/opt/stellar/horizon/etc/horizon.env", "/horizon.env"]

ADD scripts/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/local/bin/stellar-core", "run", "--conf", "/stellar-core.cfg"]
