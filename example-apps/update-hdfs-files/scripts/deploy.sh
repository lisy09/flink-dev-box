#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
APP_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $APP_DIR/../.. >/dev/null 2>&1 && pwd )"
FLINK_COMPOSE_DIR="$( cd $ROOT_DIR/flink-docker-compose >/dev/null 2>&1 && pwd )"
BUILD_DIR=${APP_DIR}/build_results
JAR_NAME=update-hdfs-files-assembly-0.1-SNAPSHOT.jar

set -ex

if [ "$(docker network ls -f name=app -q)" = '' ]; then
    docker network create app
fi

cd ${FLINK_COMPOSE_DIR} && SCALE_TASKMANAGER=3 make deploy

cd ${ROOT_DIR}/vendor/hadoop-docker && make deploy

cd ${ROOT_DIR}
curl -X POST -H "Expect:" -F "jarfile=@${BUILD_DIR}/${JAR_NAME}" \
    http://localhost:8081/jars/upload

jarid=$(curl http://localhost:8081/jars \
    | jq -r --arg JAR_NAME "${JAR_NAME}" '.files[] | select(.name == $JAR_NAME) | .id')
echo $jarid

curl -X POST \
    -H "Content-Type: application/json" \
    -d '{
        "programArgsList": [
            "--basePath",
            "hdfs://namenode:9000/flink-update-hdfs-files"
        ],
        "parallelism": 1
    }' \
    http://localhost:8081/jars/${jarid}/run | jq