FROM ubuntu:18.04

ARG VERSION
ARG CDT_VERSION
ARG CONTRACTS_VERSION

COPY checksum-eosio.sha256 .
COPY checksum-eosio_cdt.sha256 .
COPY checksum-eosio_contracts.sha256 .

ENV EOS_VERSION $VERSION
ENV EOS_CDT_VERSION $CDT_VERSION
ENV EOS_CONTRACTS_VERSION $CONTRACTS_VERSION

RUN apt-get update && apt-get install -y curl libicu60 libusb-1.0-0 libcurl3-gnutls git cmake g++

RUN curl -LO https://github.com/EOSIO/eos/releases/download/v${EOS_VERSION}/eosio_${EOS_VERSION}-1-ubuntu-18.04_amd64.deb \
    && cat checksum-eosio.sha256 | grep ${EOS_VERSION} | sha256sum -c \
    && dpkg -i eosio_${EOS_VERSION}-1-ubuntu-18.04_amd64.deb

RUN curl -LO https://github.com/EOSIO/eosio.cdt/releases/download/v${EOS_CDT_VERSION}/eosio.cdt_${EOS_CDT_VERSION}-1-ubuntu-18.04_amd64.deb \
    && cat checksum-eosio_cdt.sha256 | grep ${EOS_CDT_VERSION} |sha256sum -c \
    && dpkg -i eosio.cdt_${EOS_CDT_VERSION}-1-ubuntu-18.04_amd64.deb

RUN curl -LO https://github.com/EOSIO/eosio.contracts/archive/v${EOS_CONTRACTS_VERSION}.tar.gz \
    && cat checksum-eosio_contracts.sha256 | grep ${EOS_CONTRACTS_VERSION} | sha256sum -c \
    && tar -xzvf v${EOS_CONTRACTS_VERSION}.tar.gz --one-top-level=eosio.contracts --strip-components 1

RUN cd /eosio.contracts/ && mkdir build && cd build && cmake .. && make contracts_project --debug=j
