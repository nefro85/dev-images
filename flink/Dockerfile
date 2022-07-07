FROM openjdk:11-jre

RUN set -ex; \
  apt-get update; \
  apt-get -y install procps htop mc net-tools tree python3 python3-pip; \
  apt-get -y install gettext-base libsnappy1v5 libjemalloc-dev;

RUN pip3 install bottle glances

ARG FLINK_VERSION=1.14.4
ARG FLINK_SCALA_VERSION=2.12

ENV SW_FLINK_GZ=https://www.apache.org/dyn/closer.cgi?action=download&filename=flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_${FLINK_SCALA_VERSION}.tgz

RUN set -ex; \
  echo install flink; \
  mkdir /opt/flink; \
  wget -nv -O /opt/flink.gz "$SW_FLINK_GZ"; \
  tar -xf /opt/flink.gz -C /opt/flink --strip-components=1; \
  rm /opt/flink.gz;

ENV FLINK_HOME=/opt/flink
ENV PATH=$FLINK_HOME/bin:$PATH

ARG ZOOKEEPER_VERSION=3.7.1

ENV SW_ZK_GZ=https://www.apache.org/dyn/closer.lua/?action=download&filename=zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz

RUN set -ex; \
  echo install zookeeper; \
  mkdir /opt/zookeeper; \
  wget -nv -O /opt/zk.gz "$SW_ZK_GZ"; \
  tar -xf /opt/zk.gz -C /opt/zookeeper --strip-components=1; \
  rm /opt/zk.gz;

ENV ZOOKEEPER_HOME=/opt/zookeeper
ENV PATH=$ZOOKEEPER_HOME/bin:$PATH

COPY zk.cfg /opt/zookeeper/conf/zoo.cfg
EXPOSE 2181

WORKDIR /opt/flink
COPY flink-entrypoint.sh /opt/flink/
COPY entrypoint.sh /opt/
COPY flink-config.sh /opt/

ENTRYPOINT [ "/opt/entrypoint.sh" ]


EXPOSE 8081 6123
# glances UI
EXPOSE 61208