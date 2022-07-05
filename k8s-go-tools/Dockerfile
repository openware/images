FROM golang:1.17-alpine

RUN apk add --no-cache curl make git vim jq yq

ARG KUBECTL_VERSION=v1.24.0
RUN curl -Lo /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/bin/kubectl

ARG HELM_VERSION=v3.9.0
RUN curl -L https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar -zxO linux-amd64/helm > /usr/bin/helm \
  && chmod +x /usr/bin/helm

ARG KAIGARA_VERSION=v1.0.17
RUN curl -Lo /usr/bin/kai https://github.com/openware/kaigara/releases/download/${KAIGARA_VERSION}/kai_linux_amd64 \
  && chmod +x /usr/bin/kai

ARG KITE_VERSION=1.2.48
RUN curl -Lo /usr/bin/kite https://storage.googleapis.com/opendax-v4-binaries/kite/kite-${KITE_VERSION} \
  && chmod +x /usr/bin/kite
