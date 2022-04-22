FROM bitnami/postgresql:14-debian-10

ARG VERSION
USER root
ENV PG_CRON_VERSION 1.4.1

RUN install_packages build-essential \
&& curl -JL -o /tmp/pg_cron.tar.gz https://github.com/citusdata/pg_cron/archive/refs/tags/v$PG_CRON_VERSION.tar.gz \
&& tar xzf /tmp/pg_cron.tar.gz -C /tmp \
&& make -C /tmp/pg_cron-$PG_CRON_VERSION PG_CONFIG=/opt/bitnami/postgresql/bin/pg_config \
&& make -C /tmp/pg_cron-$PG_CRON_VERSION PG_CONFIG=/opt/bitnami/postgresql/bin/pg_config install \
&& rm -rf /tmp/pg_cron-$PG_CRON_VERSION /tmp/pg_cron.tar.gz \

USER 1001
