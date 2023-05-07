# Github self hosted runner

Base on: https://docs.github.com/en/enterprise-cloud@latest/actions/hosting-your-own-runners/adding-self-hosted-runners

### Requirements

Define environment properties:
- `GH_PAT` access token
- `GH_OWNER` github user
- `GH_REPOSITORY` repository


### Notes
```bash
docker build . -t s7i/github-runner-ubuntu
docker run -it -d --rm --name gh-runner s7i/github-runner-ubuntu /bin/bash

```

