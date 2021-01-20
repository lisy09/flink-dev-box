#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
BUILD_DIR=${ROOT_DIR}/build_results

set -ex

instance=$(docker run -d --rm \
    -v ${ROOT_DIR}:/workspace \
    -t ${BASE_IMAGE_FULL} \
    /bin/sh -c "while :; do sleep 10; done")

docker exec $instance bash -c "source /usr/local/sdkman/bin/sdkman-init.sh; \
    cd /workspace; sbt clean assembly; \
    mv /workspace/target/scala-2.12/*.jar /workspace/"

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
mv ${ROOT_DIR}/*.jar $BUILD_DIR/

docker stop $instance
