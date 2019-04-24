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
	yuanxulei/sqoop:1.99.7
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
	--mount type=bind,source=/data/hadoop/config,target=/config/hadoop \
        yuanxulei/sqoop:1.99.7
```
