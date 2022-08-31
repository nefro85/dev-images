set -ex
source ./entrypoint.sh


export GH_PAT=$(cat ./gh.pat)

echo "[TEST] as for token"
echo $(gh_ask_for_token)



