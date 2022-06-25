#!/bin/bash -e
set -e

args=("$@")

info() {
    echo
    echo Apache Flink image by nefro, enjoy...
    echo
    echo ENTRYPOINT ARGS "${args[@]}"
    echo TASK_MANAGER_NUMBER_OF_TASK_SLOTS = ${TASK_MANAGER_NUMBER_OF_TASK_SLOTS:-NOT SPECIFIED}
    echo FLINK_RUN_JOB = ${FLINK_RUN_JOB}
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
        *)
        flink_ep
    esac
}

run_glance() {
    if [[ -z "${NO_GLANCE}" ]]; then
      return
    fi
    glances -w&
}

flink_ep() {
    exec /opt/flink/flink-entrypoint.sh "${args[@]}"
}

run_cluster() {
    source /opt/flink-config.sh
    copy_plugins_if_required
    prepare_configuration

    echo Starting standalone Flink Cluster
    start-cluster.sh
    run_flink_job
    do_forever
}

run_flink_job() {
    if [[ -z "${FLINK_RUN_JOB}" ]]; then
      return
    fi
    echo "Running Flink's job..."
    flink run -d "$FLINK_RUN_JOB"
}

do_forever() {
    echo going into forever loop

    while :
    do
        sleep 1
    done

    echo forever ends...
}

main "${args[@]}"