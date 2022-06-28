#!/bin/bash -e
set -e

info() {
    echo Kafka Stack Container
    echo
    echo BROKER_ID ${KAFKA_BROKER_ID}
    echo KAFKA_LOG_DIR ${KAFKA_LOG_DIR}
    echo KAFKA_ZOOKEEPER ${KAFKA_ZOOKEEPER}
    echo KAFKA_SERVER_PROPERTIES:
    echo ${KAFKA_SERVER_PROPERTIES}
}

run_main() {
    info
    
    echo Running Glances...
    glances -w&

    echo Running ZooKeeper server
    envsubst < /opt/zoo.tmpl > ${ZOO_CFG}

    /opt/zookeeper/bin/zkServer.sh start

    run_kafka
}

run_kafka() {

    echo Running Kafka
    envsubst < /opt/kafka-server.tmpl > ${KAFKA_CFG}

    exec /opt/kafka/bin/kafka-server-start.sh ${KAFKA_CFG}

}
run_main