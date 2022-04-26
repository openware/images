ARG VERSION

FROM influxdb:${VERSION}

RUN apk update && apk --no-cache add curl wget

COPY KAIGARA_VERSION version

RUN wget "https://github.com/openware/kaigara/releases/download/$(cat version)/kaigara" \
    && chmod +x ./kaigara \
    && mv ./kaigara /usr/local/bin
