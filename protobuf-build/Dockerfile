ARG VERSION

FROM golang:${VERSION}

RUN apt-get update && \
 apt-get install -y unzip npm
RUN npm i -g grpc-tools
