FROM eclipse-temurin:11 as base

FROM base as helix-install

ARG VERSION
ENV VERSION=${VERSION} NODE_ENV='production'

ADD ./app/helix-rest.tar /opt/helix
ADD ./app/helix-front.tar /opt/helix
COPY ./app/node_modules /opt/helix/helix-front-${VERSION}/node_modules

RUN chmod +x \
  /opt/helix/helix-front-${VERSION}/node/node \
  /opt/helix/helix-front-${VERSION}/bin/start-helix-ui.sh

FROM helix-install

COPY entrypoint.sh /opt/entrypoint.sh
WORKDIR /opt/helix

LABEL org.opencontainers.image.source="https://github.com/nefro85/dev-images"

ENTRYPOINT ["sh", "/opt/entrypoint.sh" ]

EXPOSE 4200 8100
