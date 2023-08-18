#!/bin/bash

info() {
    echo "[INFO]"
    echo owner/repo: ${GH_OWNER}/${GH_REPOSITORY}
}

gh_ask_for_token() {
    local GH_API=https://api.github.com/repos/${GH_OWNER}/${GH_REPOSITORY}/actions/runners/registration-token
    curl -sX POST \
    -H 'Accept: application/vnd.github.v3+json' \
    -H "$(echo Authorization: token ${GH_PAT})" \
    ${GH_API} \
    | jq .token --raw-output

}

gh_repo() {
    echo "https://github.com/${GH_OWNER}/${GH_REPOSITORY}"
}

gen_runner_name() {
    local RND_PART=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
    echo "github-runner-${RND_PART}"
}

run_gh_runner() {
    echo "[CONFIG]"

    local REG_TOKEN=$(gh_ask_for_token)

    ./config.sh --unattended \
    --url $(gh_repo) \
    --token $REG_TOKEN \
    --name $(gen_runner_name)

    trap "cleanup $REG_TOKEN; exit 130" INT
    trap "cleanup $REG_TOKEN; exit 143" TERM

    echo "[RUN]"
    ./run.sh

}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --token $1
}

main() {
    info
    run_gh_runner
}

# if [[ "$0" == "./test_entrypoint.sh" ]]; then
#     echo [SKIP] NO RUN OF MAIN DUE TEST EXECUTION
#     return
# fi
main