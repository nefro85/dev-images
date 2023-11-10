# Kafka Docker Image

### Runing options 

With Zookeeper: 

```bash
docker run --rm -d --name kafka -p 61208:61208 -p 9092:9092 -p 2181:2185 s7i/kafka
```

With Kraft:
```bash
docker run --rm -d --name kafka -p 61208:61208 -p 9092:9092 s7i/kafka kraft
```
