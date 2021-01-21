#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
APP_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $APP_DIR/../.. >/dev/null 2>&1 && pwd )"

set -ex

docker exec namenode hadoop fs -ls /flink-update-hdfs-files