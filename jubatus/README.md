# jubatus

Distributed Online Machine Learning Framework

## Basic Usage

```
$ docker run \
    --detach \
    --name jubarecommender \
    --publish 9199:9199 \
    suin/jubatus jubarecommender \
    --configpath /opt/jubatus/share/jubatus/example/config/recommender/default.json
```

