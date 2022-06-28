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
    add_default_config
    envsubst < /opt/kafka-server.tmpl > ${KAFKA_CFG}

    exec /opt/kafka/bin/kafka-server-start.sh ${KAFKA_CFG}

}

add_default_config() {
    if [[ -z "${KAFKA_SERVER_PROPERTIES}" ]]; then
      export KAFKA_SERVER_PROPERTIES=$(cat /opt/default.properites)
    fi
}

run_main