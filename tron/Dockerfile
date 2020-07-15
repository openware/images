FROM sullof/ubu18jdk8node10redis
LABEL maintainer="Francesco Sullo <francesco@sullo.co>"

RUN mkdir -p tron/conf
WORKDIR /tron

RUN mkdir /tron/app
ADD app/package.json /tron/app/package.json
RUN cd app && npm install

RUN mkdir FullNode
ADD conf/full.conf FullNode/fullnode.conf
ADD conf/FullNode.jar FullNode/FullNode.jar

RUN mkdir BlockParser
ADD conf/run.sh BlockParser/run.sh
ADD conf/BlockParser.jar BlockParser/BlockParser.jar

RUN mkdir eventron
ADD conf/process.json eventron/process.json
ADD conf/eventron eventron/eventron

ADD app/index.js app/index.js
ADD app/version.js app/version.js
ADD app/src app/src
ADD scripts scripts
RUN chmod +x scripts/accounts-generation.sh

ADD tronWeb tronWeb
RUN chmod +x tronWeb

ADD pre-approve.sh pre-approve.sh
ADD tron.sh tron
RUN chmod +x tron

CMD ["./tron", "v2.1.1"]
