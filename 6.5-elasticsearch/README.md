# Домашнее задание к занятию "6.5. Elasticsearch"

## Задача 1

Используя докер образ elasticsearch:7 как базовый:

- составьте Dockerfile-манифест для elasticsearch

```
Ответ:

# cat Dockerfile
FROM docker.elastic.co/elasticsearch/elasticsearch:7.17.5@sha256:76344d5f89b13147743db0487eb76b03a7f9f0cd55abe8ab887069711f2ee27d
LABEL elasticsearch DZ6.5 netology
ENV PATH=/usr/lib:/usr/lib/jvm/jre-11/bin:$PATH
ENV bootstrap.memory_lock=true
ENV discovery.type=single-node
ENV path.data=/var/lib/data
ENV path.logs=/var/lib/logs
ENV path.repo=/elasticsearch/snapshots
ENV node.name=netology_test
ENV ES_HEAP_SIZE="4g"
EXPOSE 9200

ADD elasticsearch.yml /elasticsearch/config/
ENV ES_HOME=/elasticsearch
RUN mkdir /var/lib/logs \
    && chown elasticsearch:elasticsearch /var/lib/logs \
    && mkdir /var/lib/data \
    && chown elasticsearch:elasticsearch /var/lib/data \
    && chown -R elasticsearch:elasticsearch /elasticsearch/
RUN mkdir /elasticsearch/snapshots &&\
chown elasticsearch:elasticsearch /elasticsearch/snapshots
USER elasticsearch

```

- соберите docker-образ и сделайте push в ваш docker.io репозиторий

```
Ответ:

docker build -t antonh2o/elasticsearch-netology .
docker push
ссылка на скачивание https://hub.docker.com/r/antonh2o/elasticsearch-netology
команда: docker pull antonh2o/elasticsearch-netology

```

- запустите контейнер из получившегося образа и выполните запрос пути / c хост-машины

```
Ответ:

{
  "name" : "netology_test",
  "cluster_name" : "docker-cluster",
  "cluster_uuid" : "ZqJJ-s0YSuCBG5vQojygew",
  "version" : {
    "number" : "7.17.5",
    "build_flavor" : "default",
    "build_type" : "docker",
    "build_hash" : "8d61b4f7ddf931f219e3745f295ed2bbc50c8e84",
    "build_date" : "2022-06-23T21:57:28.736740635Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.1",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}

```


## Задача 2

Ознакомтесь с документацией и добавьте в elasticsearch 3 индекса, в соответствии со таблицей:


|Имя | Количество реплик | Количество шард|
|----|----|----|
|ind-1 | 0 | 1 |
|ind-2 | 1 | 2 |
|ind-3 | 2 | 4 |


```
Ответ:

curl -X PUT "localhost:9200/ind-1?pretty" -H 'Content-Type: application/json' -d'
> {
>   "settings": {
>     "number_of_shards": 1,
>     "number_of_replicas": 0
>   }
> }
> '

{"type": "server", "timestamp": "2022-08-28T06:54:29,486Z", "level": "INFO", "component": "o.e.c.m.MetadataCreateIndexService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "[ind-1] creating index, cause [api], templates [], shards [1]/[0]", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }
{"type": "server", "timestamp": "2022-08-28T06:54:29,582Z", "level": "INFO", "component": "o.e.c.r.a.AllocationService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "Cluster health status changed from [YELLOW] to [GREEN] (reason: [shards started [[ind-1][0]]]).", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-1"
}

curl -X PUT "localhost:9200/ind-2?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 2,
    "number_of_replicas": 1
  }
}
'

{"type": "server", "timestamp": "2022-08-28T06:55:46,097Z", "level": "INFO", "component": "o.e.c.m.MetadataCreateIndexService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "[ind-2] creating index, cause [api], templates [], shards [2]/[1]", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-2"
}


curl -X PUT "localhost:9200/ind-3?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 4,
    "number_of_replicas": 2
  }
}
'
{"type": "server", "timestamp": "2022-08-28T06:56:20,107Z", "level": "INFO", "component": "o.e.c.m.MetadataCreateIndexService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "[ind-3] creating index, cause [api], templates [], shards [4]/[2]", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "ind-3"
}


```
Получите список индексов и их статусов, используя API и приведите в ответе на задание.

```
Ответ:

curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases qiINrjn0QSi62LpSQbB72w   1   0         41            0     38.8mb         38.8mb
green  open   ind-1            3trMcztIQuyWg2FnhLQsMw   1   0          0            0       226b           226b
yellow open   ind-3            6dkPKy5jTFqDoscQHfEinQ   4   2          0            0       904b           904b
yellow open   ind-2            HZF3P_mNTZGuH34Hp2giFg   2   1          0            0       452b           452b

curl -X GET 'http://localhost:9200/_cluster/health/ind-1?pretty'
{
  "cluster_name" : "docker-cluster",
  "status" : "green",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 1,
  "active_shards" : 1,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 0,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 100.0
}

curl -X GET 'http://localhost:9200/_cluster/health/ind-2?pretty'
{
  "cluster_name" : "docker-cluster",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 2,
  "active_shards" : 2,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 2,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}

curl -X GET 'http://localhost:9200/_cluster/health/ind-3?pretty'
{
  "cluster_name" : "docker-cluster",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 4,
  "active_shards" : 4,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 8,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}

```

Получите состояние кластера elasticsearch, используя API.

```
Ответ:

curl -XGET localhost:9200/_cluster/health/?pretty=true
{
  "cluster_name" : "docker-cluster",
  "status" : "yellow",
  "timed_out" : false,
  "number_of_nodes" : 1,
  "number_of_data_nodes" : 1,
  "active_primary_shards" : 10,
  "active_shards" : 10,
  "relocating_shards" : 0,
  "initializing_shards" : 0,
  "unassigned_shards" : 10,
  "delayed_unassigned_shards" : 0,
  "number_of_pending_tasks" : 0,
  "number_of_in_flight_fetch" : 0,
  "task_max_waiting_in_queue_millis" : 0,
  "active_shards_percent_as_number" : 50.0
}

```

Как вы думаете, почему часть индексов и кластер находится в состоянии yellow?

```
Ответ:
yellow — Указано количество реплик больше 0 но на еластере из одной ноды условие не выполняется
```

Удалите все индексы.

```
Ответ:

curl -X DELETE 'http://localhost:9200/ind-1?pretty'
{
  "acknowledged" : true
}
curl -X DELETE 'http://localhost:9200/ind-2?pretty'
{
  "acknowledged" : true
}
curl -X DELETE 'http://localhost:9200/ind-3?pretty'
{
  "acknowledged" : true
}
```

## Задача 3

Используя API зарегистрируйте данную директорию как snapshot repository c именем netology_backup.

Приведите в ответе запрос API и результат вызова API для создания репозитория.

```
Ответ:
curl -X PUT localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true
{"type": "server", "timestamp": "2022-08-28T07:02:24,437Z", "level": "INFO", "component": "o.e.s.SnapshotsService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "snapshot [netology_backup:elasticsearch/Ls1irlmBS8mpxehItVV14g] started", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }
{"type": "server", "timestamp": "2022-08-28T07:02:26,029Z", "level": "INFO", "component": "o.e.s.SnapshotsService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "snapshot [netology_backup:elasticsearch/Ls1irlmBS8mpxehItVV14g] completed with state [SUCCESS]", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }
{"snapshot":{"snapshot":"elasticsearch","uuid":"Ls1irlmBS8mpxehItVV14g","repository":"netology_backup","version_id":7170599,"version":"7.17.5","indices":[".ds-ilm-history-5-2022.08.28-000001","ind-3","test",".ds-.logs-deprecation.elasticsearch-default-2022.08.28-000001","ind-2",".geoip_databases","ind-1"],"data_streams":["ilm-history-5",".logs-deprecation.elasticsearch-default"],"include_global_state":true,"state":"SUCCESS","start_time":"2022-08-28T07:02:24.339Z","start_time_in_millis":1661670144339,"end_time":"2022-08-28T07:02:25.740Z","end_time_in_millis":1661670145740,"duration_in_millis":1401,"failures":[],"shards":{"total":11,"failed":0,"successful":11},"feature_states":[{"feature_name":"geoip","indices":[".geoip_databases"]}]}}

```

Создайте индекс test с 0 реплик и 1 шардом и приведите в ответе список индексов.
```
Ответ:
curl -X PUT "localhost:9200/test?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
{"type": "server", "timestamp": "2022-08-28T07:01:00,554Z", "level": "INFO", "component": "o.e.c.m.MetadataCreateIndexService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "[test] creating index, cause [api], templates [], shards [1]/[0]", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test"
}


curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases qiINrjn0QSi62LpSQbB72w   1   0         41            0     38.8mb         38.8mb
green  open   test             B82tzknJTIC-VsZzEj3u4A   1   0          0            0       226b           226b
```

Создайте snapshot состояния кластера elasticsearch.
Приведите в ответе список файлов в директории со snapshotами.

```
Ответ:
curl -X PUT localhost:9200/_snapshot/netology_backup/elasticsearch?wait_for_completion=true
{"type": "server", "timestamp": "2022-08-28T07:02:24,437Z", "level": "INFO", "component": "o.e.s.SnapshotsService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "snapshot [netology_backup:elasticsearch/Ls1irlmBS8mpxehItVV14g] started", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }
{"type": "server", "timestamp": "2022-08-28T07:02:26,029Z", "level": "INFO", "component": "o.e.s.SnapshotsService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "snapshot [netology_backup:elasticsearch/Ls1irlmBS8mpxehItVV14g] completed with state [SUCCESS]", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }
{"snapshot":{"snapshot":"elasticsearch","uuid":"Ls1irlmBS8mpxehItVV14g","repository":"netology_backup","version_id":7170599,"version":"7.17.5","indices":[".ds-ilm-history-5-2022.08.28-000001","ind-3","test",".ds-.logs-deprecation.elasticsearch-default-2022.08.28-000001","ind-2",".geoip_databases","ind-1"],"data_streams":["ilm-history-5",".logs-deprecation.elasticsearch-default"],"include_global_state":true,"state":"SUCCESS","start_time":"2022-08-28T07:02:24.339Z","start_time_in_millis":1661670144339,"end_time":"2022-08-28T07:02:25.740Z","end_time_in_millis":1661670145740,"duration_in_millis":1401,"failures":[],"shards":{"total":11,"failed":0,"successful":11},"feature_states":[{"feature_name":"geoip","indices":[".geoip_databases"]}]}}

elasticsearch@edd5edddc56e:/elasticsearch$ cd snapshots/
elasticsearch@edd5edddc56e:/elasticsearch/snapshots$ ll
total 60
drwxr-xr-x 1 elasticsearch elasticsearch  4096 Aug 28 07:02 ./
drwxr-xr-x 1 elasticsearch elasticsearch  4096 Aug 28 06:41 ../
-rw-rw-r-- 1 elasticsearch elasticsearch  2263 Aug 28 07:02 index-0
-rw-rw-r-- 1 elasticsearch elasticsearch     8 Aug 28 07:02 index.latest
drwxrwxr-x 9 elasticsearch elasticsearch  4096 Aug 28 07:02 indices/
-rw-rw-r-- 1 elasticsearch elasticsearch 29300 Aug 28 07:02 meta-Ls1irlmBS8mpxehItVV14g.dat
-rw-rw-r-- 1 elasticsearch elasticsearch   778 Aug 28 07:02 snap-Ls1irlmBS8mpxehItVV14g.dat
```

Удалите индекс test и создайте индекс test-2. Приведите в ответе список индексов.
```
Ответ:
curl -X DELETE 'http://localhost:9200/test?pretty'
{
  "acknowledged" : true
}

curl -X PUT "localhost:9200/test-2?pretty" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  }
}
'
{
  "acknowledged" : true,
  "shards_acknowledged" : true,
  "index" : "test-2"
}

curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases qiINrjn0QSi62LpSQbB72w   1   0         41            0     38.8mb         38.8mb
green  open   test-2           4qtjY7OHRXuUPRZB4W9TYA   1   0          0            0       226b           226b

```

Восстановите состояние кластера elasticsearch из snapshot, созданного ранее.

Приведите в ответе запрос к API восстановления и итоговый список индексов.

```
curl -X POST "localhost:9200/_snapshot/netology_backup/elasticsearch/_restore?pretty" -H 'Content-Type: application/json' -d'
{
  "indices": "test"
}
'
{
  "accepted" : true
}
root@elastic:/etc/systemd/system# {"type": "server", "timestamp": "2022-08-28T07:07:05,280Z", "level": "INFO", "component": "o.e.c.r.a.AllocationService", "cluster.name": "docker-cluster", "node.name": "netology_test", "message": "Cluster health status changed from [YELLOW] to [GREEN] (reason: [shards started [[test][0]]]).", "cluster.uuid": "ZqJJ-s0YSuCBG5vQojygew", "node.id": "PsHBwcvpQ6SNlouHSxk1dA"  }

curl -X GET 'http://localhost:9200/_cat/indices?v'
health status index            uuid                   pri rep docs.count docs.deleted store.size pri.store.size
green  open   .geoip_databases qiINrjn0QSi62LpSQbB72w   1   0         41            0     38.8mb         38.8mb
green  open   test-2           4qtjY7OHRXuUPRZB4W9TYA   1   0          0            0       226b           226b
green  open   test             -Sudwi1RRjKHKqgdllQnwg   1   0          0            0       226b           226b

```
