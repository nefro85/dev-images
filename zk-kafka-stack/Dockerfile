FROM openjdk:8-jre


ENV SW_ZK_GZ=https://www.apache.org/dyn/closer.lua/?action=download&filename=zookeeper/zookeeper-3.7.0/apache-zookeeper-3.7.0-bin.tar.gz \
    SW_KAFKA_GZ=https://www.apache.org/dyn/closer.cgi?action=download&path=/kafka/2.8.0/kafka_2.12-2.8.0.tgz

RUN set -ex; \
  apt-get update; \
  apt-get -y install procps htop mc tree python3 python3-pip;

RUN pip3 install bottle glances

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

# https://github.com/jwilder/dockerize/
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

WORKDIR /opt
COPY zk.properties /opt/zookeeper/conf/zoo.cfg
COPY kafka-server.tmpl kafka-server.tmpl
COPY entrypoint.sh entrypoint.sh

ENTRYPOINT [ "/opt/entrypoint.sh" ]

EXPOSE 2181
EXPOSE 9092
EXPOSE 61208