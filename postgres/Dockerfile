ARG VERSION

FROM bitnami/postgresql:${VERSION}

USER root

RUN install_packages build-essential
RUN apt update -y && apt install git -y

ENV PG_CRON_VERSION 1.4.1 
ENV PG_CONFIG /opt/bitnami/postgresql/bin/pg_config
RUN curl -JL -o /tmp/pg_cron.tar.gz https://github.com/citusdata/pg_cron/archive/refs/tags/v$PG_CRON_VERSION.tar.gz \
&& tar xzf /tmp/pg_cron.tar.gz -C /tmp \
&& make -C /tmp/pg_cron-$PG_CRON_VERSION PG_CONFIG=$PG_CONFIG \
&& make -C /tmp/pg_cron-$PG_CRON_VERSION PG_CONFIG=$PG_CONFIG install \
&& rm -rf /tmp/pg_cron-$PG_CRON_VERSION /tmp/pg_cron.tar.gz

RUN git clone https://github.com/michelp/pgjwt.git /tmp/pgjwt \
&& make -C /tmp/pgjwt PG_CONFIG=$PG_CONFIG install \
&& rm -rf /tmp/pgjwt

USER 1001
