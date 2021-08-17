#!/bin/bash -e
set -e

KAFKA_CFG=/opt/kafka-server.properties

echo Init Dev Stack Container

echo Running ZooKeeper server
cd /opt/zookeeper

./bin/zkServer.sh start

dockerize -wait tcp://localhost:2181

cd /opt

echo Running Kafka

dockerize -template /opt/kafka-server.tmpl:$KAFKA_CFG
/opt/kafka/bin/kafka-server-start.sh -daemon $KAFKA_CFG

glances -w&

dockerize -wait file:///opt/kafka/logs/server.log -stdout /opt/kafka/logs/server.log