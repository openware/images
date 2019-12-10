FROM debian:buster

ARG VERSION

ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN groupadd -g ${GROUP_ID} bitcoin \
	&& useradd -u ${USER_ID} -g bitcoin -s /bin/bash -m -d /bitcoin bitcoin

RUN apt-get update && apt-get -y upgrade && apt-get install -y wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /root && \
    wget -q https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz && \
    tar xvf bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz && \
    cd bitcoin-${VERSION} && \
    mv bin/* /usr/bin/ && \
    mv lib/* /usr/bin/ && \
    mv include/* /usr/bin/ && \
    mv share/* /usr/bin/ && \
    cd /root && \
    rm -Rf bitcoin-${VERSION} bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz

VOLUME ["/bitcoin"]
EXPOSE 8332 8333 18332 18333

USER bitcoin
WORKDIR /bitcoin
