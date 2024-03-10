# docker build -t s7i/ubuntu-dev-jdk11 -f Dockerfile.ubuntu-dev-jdk11 .

FROM ubuntu:latest

RUN set -ex; \
  apt-get update; \
  apt-get -y install wget curl git procps htop mc net-tools tree python3 python3-pip jq bash-completion; \
  apt-get -y install nano vim; \
  apt-get -y install openssh-server ssh pdsh sudo; \
  apt-get -y install gettext-base libsnappy1v5 libjemalloc-dev; \
  apt-get -y install openjdk-17-jdk; \
  pip3 install bottle glances; \
  rm -rf /var/lib/apt/lists/*;

RUN pip3 install bottle glances

ENV APPDEV_HOME=/opt/appdev/data \
  MAVEN_HOME=/opt/appdev/tools/mvn \
  CI_HOME=/opt/appdev/data/ci_home \
  M2_HOME=/opt/appdev/data/.m2 \
  GRADLE_USER_HOME=/opt/appdev/data/.gradle \
  SW_MVN_GZ=https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz

RUN set -ex; \
  groupadd --system --gid 7015 appdev; \
  useradd --system --home-dir ${APPDEV_HOME} --uid 7015 --gid=appdev appdev; \
  mkdir -p ${APPDEV_HOME}; \
  chown appdev:appdev -R ${APPDEV_HOME};

RUN set -ex; \
  echo install maven; \
  mkdir -p ${MAVEN_HOME}; \
  wget -nv -O ${MAVEN_HOME}/../mvn.gz "$SW_MVN_GZ"; \
  tar -xf ${MAVEN_HOME}/../mvn.gz -C ${MAVEN_HOME} --strip-components=1; \
  rm ${MAVEN_HOME}/../mvn.gz;

WORKDIR $APPDEV_HOME
USER appdev

COPY --chown=appdev:appdev jenkins.war /opt/appdev/tools/jenkins.war
COPY dev-ep.sh /dev-ep.sh

ENTRYPOINT [ "sh", "-c", "/dev-ep.sh" ]

VOLUME [ "/opt/appdev/data" ]
EXPOSE 9090
