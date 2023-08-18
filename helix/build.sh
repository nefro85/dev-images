
HELIX_REPO=/home/nefro/codebase/gh-repos/helix

mkdir ./app
cp -r ${HELIX_REPO}/helix-front/dist ./app/frontend
cp ${HELIX_REPO}/helix-front/package.json ./app/frontend/package.json
cp ${HELIX_REPO}/out/artifacts/helix_rest_jar/helix-rest.jar ./app/rest.jar

docker build -t s7i/helix:latest .

rm -rf ./app
