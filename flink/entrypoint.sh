#!/bin/bash -e
set -e

args=("$@")

source /opt/flink-config.sh

FLINK_STORAGE=file:/usr/share/flink

info() {
    echo
    echo Apache Flink image by nefro, enjoy...
    echo
    echo ENTRYPOINT ARGS "${args[@]}"
    echo
    echo Availabele environment variables:
    echo
    echo TASK_MANAGER_NUMBER_OF_TASK_SLOTS = ${TASK_MANAGER_NUMBER_OF_TASK_SLOTS:-NOT SPECIFIED}
    echo FLINK_RUN_JOB = ${FLINK_RUN_JOB:-NOT SPECIFIED}    
    echo
    echo
}

main() {
    info
    run_glance

    case $1 in
        cluster)
            run_cluster
            ;;
        ha-cluster)
            run_ha_cluster
            ;;
        *)
        flink_ep
    esac
}

run_glance() {
    if [[ -n "${NO_GLANCE}" ]]; then
      echo FLAG: NO GLANCE
      return
    fi
    glances -w&
}

flink_ep() {
    exec /opt/flink-entrypoint.sh "${args[@]}"
}

prepare_flink() {

    echo "# clean setup of flink" > "/opt/flink/conf/flink-conf.yaml"   
    set_config_option jobmanager.rpc.port: 6123
    set_config_option jobmanager.memory.process.size ${JOBMANAGER_MEMORY_PROCESS_SIZE:-1600m} 
    set_config_option taskmanager.memory.process.size ${TASKMANAGER_MEMORY_PROCESS_SIZE:-1728m} 
    set_config_option parallelism.default ${PARALLELISM_DEFAULT:-1}
    set_config_option jobmanager.execution.failover-strategy ${JOBMANAGER_EXECUTION_FAILOVER_STRATEGY:-region}

    set_config_option state.backend rocksdb
    set_config_option state.checkpoints.dir ${FLINK_STORAGE}/checkpoints
    set_config_option state.savepoints.dir ${FLINK_STORAGE}/savepoints
    set_config_option state.backend.incremental true
    set_config_option state.backend.rocksdb.timer-service.factory rocksdb

    copy_plugins_if_required

    prepare_configuration
}

run_cluster() {
    prepare_flink

    echo Starting standalone Flink Cluster
    start-cluster.sh
    run_flink_job
    post_flink_startup
}

run_ha_cluster() {
    prepare_flink

    zkServer.sh start    
     
    set_config_option high-availability zookeeper
    set_config_option high-availability.zookeeper.quorum localhost:2181
    set_config_option high-availability.zookeeper.path.root /flink
    set_config_option high-availability.cluster-id ${FLINK_HA_CLUSTER_ID:-/nefro-cluster}
    set_config_option high-availability.storageDir file:///usr/share/flink/ha/recovery    

    echo Starting HA Flink Cluster...
    start-cluster.sh
    run_flink_job
    post_flink_startup
}

run_flink_job() {
    if [[ -z "${FLINK_RUN_JOB}" ]]; then
      return
    fi
    echo "Running Flink's job..."
    flink run -d ${FLINK_RUN_JOB}
}

show_logs() {
    tail -n 1000 -f /opt/flink/log/*
}

post_flink_startup() {
    if [[ -n "${SCRIPT}" ]]; then
      echo Running Script...
      eval ${SCRIPT}
    fi

    if [[ -n "${NO_FLINK_LOGS}" ]]; then
      sleep_forever
    else
      show_logs
    fi
}

sleep_forever() {
    echo going into forever loop

    while :
    do
        sleep 1
    done

    echo forever ends...
}

main "${args[@]}"