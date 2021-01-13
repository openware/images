FROM python:3.7-alpine

ARG VERSION

WORKDIR /root

COPY checksum.sha256 .

ENV ELECTRUM_VERSION 3.3.8
ENV ELECTRUM_USER electrum
ENV ELECTRUM_HOME /home/$ELECTRUM_USER

RUN set -x && apk --update-cache add --virtual build-dependencies gcc musl-dev && \
	adduser -D $ELECTRUM_USER && \
    wget -q https://download.electrum.org/${ELECTRUM_VERSION}/Electrum-${ELECTRUM_VERSION}.tar.gz && \
	sha256sum -c checksum.sha256 && \
	pip3 install Electrum-${ELECTRUM_VERSION}.tar.gz && \
	apk del build-dependencies

RUN mkdir -p ${ELECTRUM_HOME}/.electrum/ /data && \
	ln -sf ${ELECTRUM_HOME}/.electrum/ /data && \
	chown ${ELECTRUM_USER} ${ELECTRUM_HOME}/.electrum /data

USER $ELECTRUM_USER
WORKDIR $ELECTRUM_HOME
VOLUME /data
EXPOSE 7000

COPY start-electrum.py /usr/local/bin/
CMD ["/usr/local/bin/start-electrum.py"]
