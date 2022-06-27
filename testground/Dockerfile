# GO_VERSION is the golang version this image will be built against.
ARG GO_VERSION=1.17

# BUILD CONTAINER

# Dynamically select the golang version.
FROM golang:${GO_VERSION}-buster

# Testground version
ARG VERSION

RUN apt-get update && apt-get install unzip

RUN wget -q https://github.com/testground/testground/archive/refs/heads/master.zip -O tg.zip \
  && unzip -q tg.zip \
  && mv testground-master /app

WORKDIR /app

# Download deps.
RUN go mod download

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o testground

# RUNTIME CONTAINER

FROM golang:${GO_VERSION}-buster

WORKDIR /app

COPY --from=0 /app/testground /app/

ENV PATH="/app:${PATH}"

EXPOSE 8042
