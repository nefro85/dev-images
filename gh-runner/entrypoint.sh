run_gh_runner() {
    ./config.sh --url $GH_REPO_URL --token $GH_TOKEN
    ./run.sh
}

run_gh_runner