FROM python:3.8

ARG VERSION
ENV ELECTRONCASH_USER=electroncash
ENV ELECTRONCASH_HOME=/home/$ELECTRONCASH_USER

WORKDIR /root

COPY checksum.sha256 .

RUN cd \
	&& wget -q https://github.com/Electron-Cash/Electron-Cash/releases/download/${VERSION}/Electron-Cash-${VERSION}.tar.gz \
    && sha256sum -c checksum.sha256

RUN useradd -m $ELECTRONCASH_USER && \
	pip3 install ~/Electron-Cash-${VERSION}.tar.gz && \
	rm -f ~/Electron-Cash-${VERSION}.tar.gz

RUN mkdir -p ${ELECTRONCASH_HOME}/.electron-cash/ /data && \
	ln -sf ${ELECTRONCASH_HOME}/.electron-cash/ /data && \
	chown ${ELECTRONCASH_USER} ${ELECTRONCASH_HOME}/.electron-cash /data

USER $ELECTRONCASH_USER
WORKDIR $ELECTRONCASH_HOME
VOLUME /data
EXPOSE 7000

COPY start-electron-cash.py /usr/local/bin/
CMD ["/usr/local/bin/start-electron-cash.py"]
