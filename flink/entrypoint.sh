#!/bin/bash -e
set -e

args=("$@")

info() {
    echo
    echo Apache Flink by nefro, enjoy...
    echo
    echo ENTRYPOINT ARGS "${args[@]}"
    echo TASK_MANAGER_NUMBER_OF_TASK_SLOTS = ${TASK_MANAGER_NUMBER_OF_TASK_SLOTS:-NOT SPECIFIED}
}

main() {
    info

    case $1 in
        cluster)
            run_cluster
            ;;
        *)
        flink
    esac
}

flink() {
    export DISABLE_JEMALLOC=true
    exec /opt/flink/flink-entrypoint.sh "${args[@]}"
}

run_cluster() {
    echo Starting standalone Flink Cluster
    start-cluster.sh
    do_forever
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