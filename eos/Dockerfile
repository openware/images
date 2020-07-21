FROM ubuntu:18.04

RUN apt-get update && apt-get install -y curl libicu60 libusb-1.0-0 libcurl3-gnutls git cmake g++

RUN curl -LO https://github.com/EOSIO/eos/releases/download/v1.8.9/eosio_1.8.9-1-ubuntu-18.04_amd64.deb \
    && dpkg -i eosio_1.8.9-1-ubuntu-18.04_amd64.deb

RUN curl -LO https://github.com/EOSIO/eosio.cdt/releases/download/v1.6.3/eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb \
    && dpkg -i eosio.cdt_1.6.3-1-ubuntu-18.04_amd64.deb

RUN curl -LO https://github.com/EOSIO/eosio.contracts/archive/v1.8.3.tar.gz && tar -xzvf v1.8.3.tar.gz --one-top-level=eosio.contracts --strip-components 1

RUN cd /eosio.contracts/ && mkdir build && cd build && cmake .. && make contracts_project --debug=j
