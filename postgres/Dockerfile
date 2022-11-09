ARG VERSION

FROM bitnami/postgresql:${VERSION}

USER root

RUN apt update -y && apt install git cmake python build-essential -y

ENV PG_CRON_VERSION 1.4.1
ENV PG_GRAPHQL_VERSION 0.4.1
ENV PG_CONFIG /opt/bitnami/postgresql/bin/pg_config

RUN curl -JL -o /tmp/pg_cron.tar.gz https://github.com/citusdata/pg_cron/archive/refs/tags/v$PG_CRON_VERSION.tar.gz \
    && tar xzf /tmp/pg_cron.tar.gz -C /tmp \
    && make -C /tmp/pg_cron-$PG_CRON_VERSION PG_CONFIG=$PG_CONFIG \
    && make -C /tmp/pg_cron-$PG_CRON_VERSION PG_CONFIG=$PG_CONFIG install \
    && rm -rf /tmp/pg_cron*

RUN git clone https://github.com/michelp/pgjwt.git /tmp/pgjwt \
    && make -C /tmp/pgjwt PG_CONFIG=$PG_CONFIG install \
    && rm -rf /tmp/pgjwt

RUN git clone https://github.com/graphql/libgraphqlparser -b 0.7.0 /tmp/libgraphqlparser \
    && cd /tmp/libgraphqlparser \
    && cmake . \
    && make -C /tmp/libgraphqlparser \
    && make -C /tmp/libgraphqlparser install \
    && rm -rf /tmp/libgraphqlparser && cd

RUN curl -JL -o /tmp/pg_graphql.tar.gz https://github.com/supabase/pg_graphql/archive/refs/tags/v$PG_GRAPHQL_VERSION.tar.gz \
    && tar xzf /tmp/pg_graphql.tar.gz -C /tmp \
    && make -C /tmp/pg_graphql-$PG_GRAPHQL_VERSION PG_CONFIG=$PG_CONFIG install \
    && rm -rf /tmp/pg_graphql*

USER 1001
