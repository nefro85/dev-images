
HELIX_REPO=/home/nefro/codebase/gh-repos/helix
VERSION="1.3.2-SNAPSHOT"

mkdir ./app

cp ${HELIX_REPO}/helix-agent/target/helix-agent-${VERSION}-pkg.tar ./app/helix-agent.tar

docker build --build-arg VERSION=${VERSION} -t s7i/helix-agent:latest -t s7i/helix-agent:1.3.2 .

rm -rf ./app
