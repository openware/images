FROM influxdb:1.7.9-alpine

RUN apk update && apk --no-cache add curl wget

RUN curl https://api.github.com/repos/openware/kaigara/releases/latest |\
    grep "tag_name" |\
    cut -d : -f 2 |\
    tr -d ',' |\
    xargs > version

RUN wget "https://github.com/openware/kaigara/releases/download/$(cat version)/kaigara" \
    && chmod +x ./kaigara \
    && mv ./kaigara /usr/local/bin
