
ZK_SVR=${1:-"127.0.0.1:2181"}

echo "ZOOKEEPER SERVER: ${ZK_SVR}"

java ${JVM_OPTS} -cp /opt/helix/rest.jar org.apache.helix.rest.server.HelixRestMain --zkSvr ${ZK_SVR} &

node /opt/helix/frontend/server/app.js
