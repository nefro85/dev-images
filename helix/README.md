### Apache Helix :: UI

Helix UI (frontend + rest service)


```
docker run --add-host host.docker.internal:host-gateway -p 7005:4200 --name helixui s7i/helix:latest host.docker.internal:2181
docker run --rm --name helixui -it --entrypoint /bin/bash s7i/helix:latest


```