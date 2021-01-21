#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
APP_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $APP_DIR/../.. >/dev/null 2>&1 && pwd )"
FLINK_COMPOSE_DIR="$( cd $ROOT_DIR/flink-docker-compose >/dev/null 2>&1 && pwd )"
BUILD_DIR=${APP_DIR}/build_results
JAR_NAME=update-hdfs-files-assembly-0.1-SNAPSHOT.jar

set -ex

cd ${FLINK_COMPOSE_DIR} && make undeploy
cd ${ROOT_DIR}/vendor/hadoop-docker && make undeploy
docker network rm app