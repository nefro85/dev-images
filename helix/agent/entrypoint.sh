#!/bin/bash

/opt/helix-agent-${VERSION}/bin/start-helix-agent.sh \
  --zkSvr ${ZK_SVR} \
  --cluster ${CLUSTER} \
  --instanceName ${HOSTNAME} \
  --stateModel ${STATE_MODEL}

# echo "forever loop..."
# while true; do
#     sleep 5 
# done

