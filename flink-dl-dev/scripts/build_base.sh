#!/usr/bin/env bash

readonly SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
readonly ROOT_DIR="$( cd $SCRIPT_DIR/.. >/dev/null 2>&1 && pwd )"
source $ROOT_DIR/.env

COMMANDS=docker
IFS=',' read -a commands <<< ${COMMANDS}
for COMMAND in ${commands[@]}; do
    if ! command -v ${COMMAND} &> /dev/null; then
        echo "Command could not be found: ${COMMAND}"
        exit 1
    fi
done

set -e
set -x

docker build \
    --build-arg JAVA_VERSION=${JAVA_VERSION} \
    --build-arg SCALA_VERSION=${SCALA_VERSION} \
    --build-arg MAVEN_VERSION=${BASE_MAVEN_VERSION} \
    --build-arg GRADLE_VERSION=${BASE_GRADLE_VERSION} \
    --build-arg SBT_VERSION=${BASE_SBT_VERSION} \
    --build-arg SBT_BLOOP_VERSION=${SBT_BLOOP_VERSION} \
    -t ${BASE_IMAGE_FULL} \
    ${ROOT_DIR}/docker