#!/bin/bash

## replace hadoop config
HADOOP_EXTRA_CONF_DIR=/config/hadoop
if [ -d "$HADOOP_EXTRA_CONF_DIR" ]; then
	cp $HADOOP_EXTRA_CONF_DIR/* /usr/local/hadoop/etc/hadoop/
fi

sqoop2-tool upgrade || exit 1
sqoop2-tool verify || exit 2

sqoop2-server start

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
