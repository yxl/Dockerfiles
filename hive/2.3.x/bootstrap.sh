#!/bin/bash

## replace hadoop config
HADOOP_EXTRA_CONF_DIR=/config/hadoop
if [ -d "$HADOOP_EXTRA_CONF_DIR" ]; then
	cp $HADOOP_EXTRA_CONF_DIR/* /usr/local/hadoop/etc/hadoop/
fi

## replace hive config
: ${EXTRA_CONF_DIR:=/config/hive}

if [ -d "$EXTRA_CONF_DIR" ]; then
	cp $EXTRA_CONF_DIR/* /usr/local/hive/conf
fi

# init hive
$HADOOP_HOME/bin/hdfs dfs -mkdir /tmp
$HADOOP_HOME/bin/hdfs dfs -mkdir -p /user/hive/warehouse
$HADOOP_HOME/bin/hdfs dfs -chmod g+w /tmp
$HADOOP_HOME/bin/hdfs dfs -chmod g+w /user/hive/warehouse
schematool --dbType mysql --initSchema

nohup hive --service metastore &
hiveserver2
# wait for ever
tail -f /dev/null
