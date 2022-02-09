FROM supabase/postgres:13.3.0

RUN apt update -y && apt install -y curl wget

RUN curl https://api.github.com/repos/openware/kaigara/releases/latest |\
    grep "tag_name" |\
    cut -d : -f 2 |\
    tr -d ',' |\
    xargs > version

RUN wget "https://github.com/openware/kaigara/releases/download/$(cat version)/kaigara" \
    && chmod +x ./kaigara \
    && mv ./kaigara /usr/local/bin
