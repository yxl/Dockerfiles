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

nohup hive --service metastore &
hiveserver2
