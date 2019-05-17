#!/bin/sh

hue syncdb --noinput
hue migrate

# 启动 HUE
nohup supervisor &

# 启动 HIVE
/etc/bootstrap.sh
