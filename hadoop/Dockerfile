FROM s7i/ubuntu-dev-jdk11


ARG HADOOP_GZ=https://dlcdn.apache.org/hadoop/common/stable/hadoop-3.3.5.tar.gz

ENV HADOOP_DIR=/opt/hadoop

WORKDIR ${HADOOP_DIR}

RUN groupadd --system --gid=10101 hadoop \
  && useradd --system --home-dir ${HADOOP_DIR} --uid=10101 --gid=hadoop hadoop

RUN set -ex; \
  wget -nv -O /opt/hadoop.gz "${HADOOP_GZ}"; \
  tar -xf /opt/hadoop.gz -C ${HADOOP_DIR} --strip-components=1; \
  rm /opt/hadoop.gz; \
  chown -R hadoop:hadoop .;

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64 \
  HDFS_DATA_DIR=/opt/hadoop/data/hdfs \
  PATH=${PATH}:/opt/hadoop/bin:/opt/hadoop/sbin

COPY entrypoint.sh entrypoint.sh
RUN bash +x ./entrypoint.sh init

COPY core-site.xml /opt/hadoop/etc/hadoop/core-site.xml
COPY hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml

#USER hadoop
EXPOSE 22 9000 50070
VOLUME [ "/opt/hadoop/data/hdfs" ]
