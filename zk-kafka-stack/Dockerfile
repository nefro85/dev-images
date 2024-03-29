FROM eclipse-temurin:17

RUN set -ex; \
  apt-get update; \
  apt-get -y install gettext-base procps htop mc net-tools tree python3 python3-pip; \
  rm -rf /var/lib/apt/lists/*; \
  pip3 install bottle glances;

ARG ZK_VERSION=3.7.1
ARG KAFKA_VERSION=2.8.1

ENV SW_ZK_GZ=https://www.apache.org/dyn/closer.lua/?action=download&filename=zookeeper/zookeeper-${ZK_VERSION}/apache-zookeeper-${ZK_VERSION}-bin.tar.gz \
    SW_KAFKA_GZ=https://www.apache.org/dyn/closer.cgi?action=download&path=/kafka/${KAFKA_VERSION}/kafka_2.12-${KAFKA_VERSION}.tgz \
    SW_KAFDROP_JAR=https://github.com/obsidiandynamics/kafdrop/releases/download/4.0.1/kafdrop-4.0.1.jar 

RUN set -ex; \
  echo install zookeeper; \
  mkdir /opt/zookeeper; \
  wget -nv -O /opt/zk.gz "$SW_ZK_GZ"; \
  tar -xf /opt/zk.gz -C /opt/zookeeper --strip-components=1; \
  rm /opt/zk.gz;

RUN set -ex; \
  echo install kafka; \
  mkdir /opt/kafka; \
  wget -nv -O /opt/kafka.gz "$SW_KAFKA_GZ"; \
  tar -xf /opt/kafka.gz -C /opt/kafka --strip-components=1; \
  rm /opt/kafka.gz;

RUN set -ex; \
  echo install kafdrop; \
  mkdir /opt/kafdrop; \
  wget -nv -O /opt/kafdrop/kafdrop.jar "$SW_KAFDROP_JAR";

COPY . /opt/
WORKDIR /opt

ENV KAFKA_BROKER_ID=123 \
    KAFKA_LOG_DIR=/data/kafka/kafka-logs \
    KAFKA_HOME=/opt/kafka \
    KAFKA_ZOOKEEPER=localhost:2181/kafka \
    KAFKA_SERVER_PROPERTIES= \
    ZOOKEEPER_DATA=/data/zookeeper/dataDir \
    ZOOKEEPER_TICK_TIME=2000 \
    ZOOKEEPER_INIT_LIMIT=10 \
    ZOOKEEPER_SYNC_LIMIT=5 \
    ZOOKEEPER_CLIENT_PORT=2181 \
    KAFKA_CFG=/opt/kafka-server.properties \
    ZOO_CFG=/opt/zookeeper/conf/zoo.cfg \
    KAFDROP_JVM_OPTS="-Dlogger.kafdrop.level=WARN -Dlogger.kafdrop_service.level=WARN -Xms32M -Xmx64M -XX:-TieredCompilation -XX:+UseStringDeduplication" \
    KAFDROP_ARGS=""

ENV PATH=/opt/kafka/bin:/opt/zookeeper/bin:$PATH

ENTRYPOINT [ "/opt/entrypoint.sh" ]
VOLUME [ "/data" ]

EXPOSE 2181
EXPOSE 7000
EXPOSE 9092
EXPOSE 61208
