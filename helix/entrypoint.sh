
ZK_SVR=${1:-"127.0.0.1:2181"}

cat <<EOF
ZOOKEEPER SERVER: ${ZK_SVR}
HELIX VERSION: ${VERSION}

EOF

restapi=./helix-rest-${VERSION}
frontend=./helix-front-${VERSION}
frontendCfg=$frontend/dist/server/config.js

sed -i 's/exports\.PROXY_URL = '\''www\.example\.com'\'';/exports\.PROXY_URL = undefined;/' $frontendCfg

echo "Frontend Config:"
cat $frontendCfg

$restapi/bin/run-rest-admin.sh --zkSvr ${ZK_SVR} &
$frontend/bin/start-helix-ui.sh
