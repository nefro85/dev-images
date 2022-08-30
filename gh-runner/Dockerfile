FROM ubuntu:latest

RUN set -ex; \
  apt-get update; \
  apt-get -y install wget curl git procps htop mc net-tools tree python3 python3-pip jq bash-completion; \
  apt-get -y install gettext-base libsnappy1v5 libjemalloc-dev; \
  apt-get -y install openjdk-11-jdk; \
  pip3 install bottle glances; \
  rm -rf /var/lib/apt/lists/*;

RUN set -ex; \
  mkdir -p /opt/actions-runner;

WORKDIR /opt/actions-runner


ARG GH_ACTION_GZ_URL=https://github.com/actions/runner/releases/download/v2.296.0/actions-runner-linux-x64-2.296.0.tar.gz
RUN set -ex; \
  wget -nv -O ./actions-runner-linux-x64.tar.gz "$GH_ACTION_GZ_URL"; \
  tar xzf ./actions-runner-linux-x64.tar.gz; \
  rm ./actions-runner-linux-x64.tar.gz;

ENV RUNNER_ALLOW_RUNASROOT="scary me" \
    GH_REPO_URL= \
    GH_TOKEN=

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT [ "sh", "/opt/entrypoint.sh" ]
