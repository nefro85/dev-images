@echo on
docker build --build-arg FLINK_VERSION=1.15.1 -t s7i/flink:1.15.1 .