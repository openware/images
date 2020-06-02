FROM debian:buster

ARG USER_ID
ARG GROUP_ID

ENV HOME /dash

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} dash
RUN useradd -u ${USER_ID} -g dash -s /bin/bash -m -d /dash dash

RUN chown dash:dash -R /dash
COPY checksum.sha256 /tmp/checksum.sha256

ADD https://github.com/dashpay/dash/releases/download/v0.15.0.0/dashcore-0.15.0.0-x86_64-linux-gnu.tar.gz /tmp/
RUN cd /tmp/ && cat checksum.sha256 | sha256sum -c -
RUN tar -xvf /tmp/dashcore-*.tar.gz -C /tmp/
RUN cp /tmp/dashcore*/bin/*  /usr/local/bin
RUN rm -rf /tmp/dashcore*

ADD ./scripts /usr/local/bin
RUN chmod a+x /usr/local/bin/*

USER dash

VOLUME ["/dash"]

EXPOSE 9998 9999 19998 19999

WORKDIR /dash

CMD ["dash_oneshot"]