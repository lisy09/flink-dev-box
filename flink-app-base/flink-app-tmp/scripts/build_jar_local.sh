#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
BUILD_DIR=${ROOT_DIR}/build_results

set -ex

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR
sbt clean assembly
mv ${ROOT_DIR}/target/scala-2.12/*.jar ${BUILD_DIR}/

docker stop $instance
