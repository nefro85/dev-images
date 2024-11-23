FROM eclipse-temurin:11

RUN set -ex; \
  apt-get update; \
  apt-get -y install gettext-base procps htop mc net-tools tree python3 python3-pip; \
  rm -rf /var/lib/apt/lists/*; \
  pip3 install bottle glances;

ARG KAFKA_VERSION=3.7.1

ENV SW_KAFKA_GZ=https://www.apache.org/dyn/closer.cgi?action=download&path=/kafka/${KAFKA_VERSION}/kafka_2.12-${KAFKA_VERSION}.tgz

RUN set -ex; \
  echo install kafka; \
  mkdir /opt/kafka; \
  wget -nv -O /opt/kafka.gz "$SW_KAFKA_GZ"; \
  tar -xf /opt/kafka.gz -C /opt/kafka --strip-components=1; \
  rm /opt/kafka.gz;

COPY . /opt/
WORKDIR /opt

ENV KAFKA_BROKER_ID=123 \
    KAFKA_LOG_DIR=/data/kafka/kafka-logs \
    KAFKA_HOME=/opt/kafka \
    KAFKA_SERVER_PROPERTIES= \
    KAFKA_CFG=/opt/kafka-server.properties

ENV PATH=/opt/kafka/bin:$PATH

ENTRYPOINT [ "/opt/entrypoint.sh" ]
VOLUME [ "/data" ]

EXPOSE 2181
EXPOSE 9092
EXPOSE 61208