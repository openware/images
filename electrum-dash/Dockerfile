FROM python:3.7-alpine

ARG VERSION

WORKDIR /root

COPY checksum.sha256 .

ENV ELECTRUM_VERSION $VERSION
ENV ELECTRUM_USER electrum
ENV ELECTRUM_HOME /home/$ELECTRUM_USER

RUN set -x && apk --update-cache add --virtual build-dependencies gcc musl-dev openssl-dev gmp-dev && \
	adduser -D $ELECTRUM_USER && \
	wget -q https://github.com/akhavr/electrum-dash/releases/download/${ELECTRUM_VERSION}/Dash-Electrum-${ELECTRUM_VERSION}.tar.gz && \
	sha256sum -c checksum.sha256 && \
	pip3 install Dash-Electrum-${ELECTRUM_VERSION}.tar.gz && \
	apk del build-dependencies gcc musl-dev openssl-dev && \
	rm -f Dash-Electrum-${ELECTRUM_VERSION}.tar.gz

RUN mkdir -p ${ELECTRUM_HOME}/.electrum-dash/ /data && \
	ln -sf ${ELECTRUM_HOME}/.electrum-dash/ /data && \
	chown ${ELECTRUM_USER} ${ELECTRUM_HOME}/.electrum-dash /data

# Install Kaigara
ARG KAIGARA_VERSION=0.1.9
RUN wget -O /usr/bin/kaigara https://github.com/openware/kaigara/releases/download/${KAIGARA_VERSION}/kaigara \
	&& chmod +x /usr/bin/kaigara

USER $ELECTRUM_USER
WORKDIR $ELECTRUM_HOME
VOLUME /data
EXPOSE 7000

COPY start-electrum.py /usr/local/bin/
CMD ["/usr/local/bin/start-electrum.py"]
