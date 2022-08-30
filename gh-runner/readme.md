# Github self hosted runner

### Notes
```bash
docker build . -t s7i/github-runner-ubuntu
docker run -it -d --rm --name gh-runner s7i/github-runner-ubuntu /bin/bash

```

