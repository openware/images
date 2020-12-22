FROM debian:stretch-slim

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN groupadd -g ${GROUP_ID} bitcoincash \
	&& useradd -u ${USER_ID} -g bitcoincash -s /bin/bash -m -d /bitcoincash bitcoincash

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/*

COPY VERSION /tmp/VERSION
COPY checksum.sha256 /tmp/checksum.sha256

RUN set -ex \
	&& cd /tmp \
	&& wget -qO bitcoin-cash.tar.gz "https://download.bitcoinabc.org/bchn/$(cat VERSION)/linux/bitcoin-abc-$(cat VERSION)-x86_64-linux-gnu.tar.gz" \
	&& cat checksum.sha256 | sha256sum -c - \
	&& tar -xzvf bitcoin-cash.tar.gz -C /usr/local --strip-components=1 --exclude=*-qt \
	&& rm -rf /tmp/*

VOLUME ["/bitcoincash"]
EXPOSE 8332 8333 18332 18333

WORKDIR /bitcoincash

COPY scripts/docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
