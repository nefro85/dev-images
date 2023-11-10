#!/bin/bash -e
set -e

args=("$@")

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
    run_glance

    run_zoo
    # we have to wait
    sleep 20
    exec_script&
    run_kafka
}

run_glance() {
    echo Running Glances...
    glances -w&
}

run_zoo() {
    echo Running ZooKeeper server
    envsubst < /opt/zoo.tmpl > ${ZOO_CFG}

    /opt/zookeeper/bin/zkServer.sh start
}

run_kafka() {
    echo Running Kafka...
    add_default_config
    envsubst < /opt/kafka-server.tmpl > ${KAFKA_CFG}

    exec /opt/kafka/bin/kafka-server-start.sh ${KAFKA_CFG}
}

add_default_config() {
    if [[ -z "${KAFKA_SERVER_PROPERTIES}" ]]; then
      export KAFKA_SERVER_PROPERTIES=$(cat /opt/default.properites)
    fi
}

exec_script() {
    if [[ -n "${SCRIPT}" ]]; then
      echo Running Script...
      eval ${SCRIPT}
    fi
}

get_config_option() {
  local option=$1  
  local escaped_option=$(echo ${option} | sed -e "s/\./\\\./g")

  grep -vxE '[[:blank:]]*([#;].*)?' "${KAFKA_CFG}" \
    | grep -E "^${escaped_option}=.*" \
    | grep -oP "=.{0}\K.*"
}

init_log_dir() {
    LOG_DIR=$(get_config_option log.dirs)

    echo "Logdir: ${LOG_DIR}"    

    if [[ ! -e ${LOG_DIR} ]]; then
        mkdir -p ${LOG_DIR}
        CLUSTER_UID=$(${KAFKA_HOME}/bin/kafka-storage.sh random-uuid)
        echo "New Cluster UID: ${CLUSTER_UID}"
        ${KAFKA_HOME}/bin/kafka-storage.sh format -t ${CLUSTER_UID} -c ${KAFKA_CFG}
    fi
}

start_kraft_kafka() {
    run_glance
    exec_script&
    run_kafdrop&

    envsubst < /opt/kraft-server.tmpl > ${KAFKA_CFG}

    echo "Starting Kafka (Kraft) with configuration: ${KAFKA_CFG}"
    init_log_dir

    ${KAFKA_HOME}/bin/kafka-server-start.sh ${KAFKA_CFG}
}

run_kafdrop() {
    java --add-opens=java.base/sun.nio.ch=ALL-UNNAMED \
    -Dserver.port=7000 -Dmanagement.server.port=7000 ${KAFDROP_JVM_OPTS}\
    -jar /opt/kafdrop/kafdrop.jar \
    --kafka.brokerConnect=localhost:9092 ${KAFDROP_ARGS}
}

case ${args[0]} in
  kraft)
    start_kraft_kafka "${args[@]:1}"
    ;;
  *)
  run_main "${args[@]:1}"
esac
