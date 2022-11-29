FROM debian:stretch

EXPOSE 5432
EXPOSE 8000
EXPOSE 11625
EXPOSE 11626

RUN apt-get update \
  && apt-get install -y wget curl git libpq-dev libsqlite3-dev libsasl2-dev postgresql-client sudo vim zlib1g-dev jq netcat \
  && apt-get clean

ARG VERSION
COPY VERSION_HORIZON .
COPY checksum.sha256 .

# Links were taken from official image: https://github.com/stellar/docker-stellar-core-horizon/blob/master/install
# Stellar-core & Horizon

RUN wget -q https://s3.amazonaws.com/stellar.org/releases/stellar-core/stellar-core-${VERSION}_amd64.deb \
  && wget -q https://github.com/stellar/go/releases/download/horizon-v$(cat VERSION_HORIZON)/horizon-v$(cat VERSION_HORIZON)-linux-amd64.tar.gz \
  && sha256sum -c checksum.sha256 \
  && dpkg -i stellar-core-${VERSION}_amd64.deb \
  && rm stellar-core-${VERSION}_amd64.deb \
  && tar -zxvf horizon-v$(cat VERSION_HORIZON)-linux-amd64.tar.gz \
  && mv /horizon-v$(cat VERSION_HORIZON)-linux-amd64/horizon /usr/local/bin \
  && chmod +x /usr/local/bin/horizon \
  && rm -rf horizon-v$(cat VERSION_HORIZON)-linux-amd64.tar.gz /horizon-v$(cat VERSION_HORIZON)-linux-amd64

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
