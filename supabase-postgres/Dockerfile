ARG VERSION

FROM supabase/postgres:${VERSION}

RUN apt update -y && apt install -y curl wget

COPY KAIGARA_VERSION version

RUN wget "https://github.com/openware/kaigara/releases/download/$(cat version)/kaigara" \
    && chmod +x ./kaigara \
    && mv ./kaigara /usr/local/bin
