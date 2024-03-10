#!/bin/bash

args=("$@")

function main() {
    whoami
    run_glance
    run_jenkins

}

function run_glance() {
    echo Running Glances...
    glances -w&
}

function run_jenkins() {
    JK_JAR=/opt/appdev/tools/jenkins.war

    echo Running Jenkins...
    java ${JENKINS_JVM_OPTS} -DJENKINS_HOME=${CI_HOME} -jar ${JK_JAR} --httpPort=9090
}


main
