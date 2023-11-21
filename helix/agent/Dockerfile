FROM eclipse-temurin:11 as base

ARG VERSION
ENV VERSION=${VERSION} \
  ZK_SVR="zookeeper:2181" \
  CLUSTER="my-cluster" \
  STATE_MODEL="OnlineOffline"

ADD ./app/helix-agent.tar /opt

COPY entrypoint.sh /opt/entrypoint.sh

WORKDIR /opt/helix-agent-${VERSION}

RUN chmod +x \
  /opt/entrypoint.sh \
  /opt/helix-agent-${VERSION}/bin/start-helix-agent.sh

LABEL org.opencontainers.image.source="https://github.com/nefro85/dev-images"

ENTRYPOINT [ "sh", "-c", "/opt/entrypoint.sh" ]
