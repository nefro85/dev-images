FROM ubuntu:latest

RUN set -ex; \
  apt-get update; \
  apt-get install -y nodejs npm openjdk-11-jdk; \
  rm -rf /var/lib/apt/lists/*;

COPY ./app /opt/helix
COPY entrypoint.sh /opt/entrypoint.sh
WORKDIR /opt/helix/frontend
RUN npm install --force

LABEL org.opencontainers.image.source="https://github.com/nefro85/dev-images"

ENTRYPOINT ["sh", "/opt/entrypoint.sh" ]

EXPOSE 4200 8100
