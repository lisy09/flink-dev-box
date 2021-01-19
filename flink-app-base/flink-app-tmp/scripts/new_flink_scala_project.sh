#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -ex

sbt new tillrohrmann/flink-project.g8 -v

BUILD_SBT_FILEPATH=$(find . | grep build.sbt)
NEW_PROJECT_DIR=$(dirname "${BUILD_SBT_FILEPATH}")

mv ${BUILD_SBT_FILEPATH} $ROOT_DIR
mv ${NEW_PROJECT_DIR}/src $ROOT_DIR
rm -rf $ROOT_DIR/project
mv ${NEW_PROJECT_DIR}/project $ROOT_DIR
sed -i -E 's|(sbt.version=.+)||g' project/build.properties

rm -rf ${NEW_PROJECT_DIR}