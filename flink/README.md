
Motivation: Single container with flink cluster.



### Docker
```
docker build . -t s7i/flink

docker run --rm -p 8100:8081 -it s7i/flink cluster

docker run --rm -p 8100:8081 -p 61208:61208 -e TASK_MANAGER_NUMBER_OF_TASK_SLOTS=10 -it s7i/flink cluster

docker run --rm -p 8100:8081 -p 61208:61208 -e TASK_MANAGER_NUMBER_OF_TASK_SLOTS=10 -e FLINK_RUN_JOB=/opt/flink/examples/streaming/WordCount.jar -it s7i/flink cluster

```

Version 1.17.2
```bash
docker build --build-arg FLINK_VERSION=1.17.2 -t s7i/flink:1.17.2 .
```
