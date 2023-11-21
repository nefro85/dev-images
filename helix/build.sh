
HELIX_REPO=/home/nefro/codebase/gh-repos/helix
VERSION="1.3.2-SNAPSHOT"

mkdir ./app

cp -r ${HELIX_REPO}/helix-front/node_modules ./app/node_modules
cp ${HELIX_REPO}/helix-front/target/helix-front-${VERSION}-pkg.tar ./app/helix-front.tar
cp ${HELIX_REPO}/helix-rest/target/helix-rest-${VERSION}-pkg.tar ./app/helix-rest.tar


docker build --build-arg VERSION=${VERSION} -t s7i/helix:latest -t s7i/helix:1.3.2 .

rm -rf ./app
