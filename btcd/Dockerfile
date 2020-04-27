FROM golang:1.13-alpine AS builder

ENV GO111MODULE=on

RUN cd /root && \
    go get github.com/btcsuite/btcd@f3ec130 && \
    go get github.com/btcsuite/btcwallet@2fed914

FROM alpine:3.9

RUN apk add ca-certificates

WORKDIR btcd

RUN addgroup -g 1000 btc && \
    adduser -u 1000 -G btc -s /bin/bash -D -h /btc btc

COPY --from=builder /go/bin/btcd /bin/btcd
COPY --from=builder /go/bin/btcwallet /bin/btcwallet

VOLUME ["/btc"]

USER btc
WORKDIR /btc
EXPOSE 8333 8334

CMD ["/bin/btcd"]
