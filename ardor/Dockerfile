FROM openjdk:12-jdk-alpine

LABEL version="2.2.3"
ENV NRSVersion=2.2.3
ENV NRSPlatform=ardor

RUN \
  apk update && \
  apk add wget gpgme && \
  mkdir /nxt-boot && \
  wget https://bitbucket.org/Jelurida/${NRSPlatform}/downloads/${NRSPlatform}-client-${NRSVersion}.zip && \
  wget https://bitbucket.org/Jelurida/${NRSPlatform}/downloads/${NRSPlatform}-client-${NRSVersion}.zip.asc && \
  gpg --keyserver pool.sks-keyservers.net --recv-key 0xC654D7FCFF18FD55 && \
  gpg --verify ${NRSPlatform}-client-${NRSVersion}.zip.asc && \
  mkdir /ardor && ln -s /ardor /nxt && \
  unzip -o ${NRSPlatform}-client-${NRSVersion}.zip && \
  rm -f ${NRSPlatform}-client-${NRSVersion}.zip ${NRSPlatform}-client-${NRSVersion}.zip.asc ${NRSPlatform}/*.exe ${NRSPlatform}/changelogs/*.txt

ADD scripts /nxt-boot/scripts

VOLUME /${NRSPlatform}/conf
VOLUME /${NRSPlatform}/db
WORKDIR /${NRSPlatform}

ENV NXTNET test

COPY ./init-nxt.sh /nxt-boot/

# Nxt test net
EXPOSE 6874 6876
# NXT main net
EXPOSE 7874 7876
# Ardor test net
EXPOSE 26874 26876
# Ardor main net
EXPOSE 27874 27876

CMD ["/nxt-boot/init-nxt.sh", "/bin/sh"]
