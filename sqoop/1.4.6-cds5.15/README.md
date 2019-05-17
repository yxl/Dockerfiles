Run Sqoop with Docker

## Prequirements

Assume you already have one Hadoop cluster whose master node host is `hadoop-master`;

## Start Sqoop

```bash
docker service create \
	--name sqoop \
	--hostname sqoop \
	--network swarm-net \
	--replicas 1 \
	--detach=true \
	--mount type=bind,source=/etc/localtime,target=/etc/localtime \
	yuanxulei/sqoop:1.4.6-hive1-1.1.0-cdh5.15.0
```
## Custom configuration
To specifiy the hadoop conffiles, refer to the following script.

The `/config/hadoop` path is where new conf files to be replaces, you don't have to put all the files.

```bash
docker service create \
        --name sqoop \
        --hostname sqoop \
        --network swarm-net \
        --replicas 1 \
        --detach=true \
        --mount type=bind,source=/etc/localtime,target=/etc/localtime \
        --mount type=bind,source=/data/hive/config,target=/config/hive \
        --mount type=bind,src=/data/hadoop/config,dst=/config/hadoop \
        --mount type=bind,src=/data/hadoop/hdfs,dst=/tmp/hadoop-root \
        --mount type=bind,src=/data/hadoop/logs,dst=/usr/local/hadoop/logs \
        yuanxulei/sqoop:1.4.6-hive1-1.1.0-cdh5.15.0
```
