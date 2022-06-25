FROM openjdk:11-jre

ENV SW_FLINK_GZ=https://www.apache.org/dyn/closer.cgi?action=download&filename=flink/flink-1.14.4/flink-1.14.4-bin-scala_2.12.tgz

RUN set -ex; \
  apt-get update; \
  apt-get -y install procps htop mc net-tools tree python3 python3-pip; \
  apt-get -y install gettext-base libsnappy1v5 libjemalloc-dev;

RUN pip3 install bottle glances

RUN set -ex; \
  echo install flink; \
  mkdir /opt/flink; \
  wget -nv -O /opt/flink.gz "$SW_FLINK_GZ"; \
  tar -xf /opt/flink.gz -C /opt/flink --strip-components=1; \
  rm /opt/flink.gz;


ENV FLINK_HOME=/opt/flink
ENV PATH=$FLINK_HOME/bin:$PATH
WORKDIR /opt/flink
COPY flink-entrypoint.sh /opt/flink/
COPY entrypoint.sh /opt/
COPY flink-config.sh /opt/

ENTRYPOINT [ "/opt/entrypoint.sh" ]


EXPOSE 8081 6123
# glances UI
EXPOSE 61208