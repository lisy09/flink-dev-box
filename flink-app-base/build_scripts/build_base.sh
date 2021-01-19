#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -x

docker build \
    --build-arg JAVA_VERSION=${JAVA_VERSION} \
    --build-arg MAVEN_VERSION=${MAVEN_VERSION} \
    --build-arg GRADLE_VERSION=${GRADLE_VERSION} \
    --build-arg SCALA_VERSION=${SCALA_VERSION} \
    --build-arg SBT_VERSION=${SBT_VERSION} \
    --build-arg FLINK_VERSION=${FLINK_VERSION} \
    -t ${BASE_IMAGE_FULL} \
    ${ROOT_DIR}/docker

set +x