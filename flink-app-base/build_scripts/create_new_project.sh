#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"

set -xe

TARGET_DIR=${ROOT_DIR}/../flink-app-tmp
[ -d ${TARGET_DIR} ] && echo "Directory ${TARGET_DIR} exists." && exit 1

cp -r ${ROOT_DIR}/flink-app-tmp ${TARGET_DIR}
cp ${ROOT_DIR}/.env ${TARGET_DIR}

sed -i -r "s|#BASE_IMAGE_FULL|${BASE_IMAGE_FULL}|g" ${TARGET_DIR}/.devcontainer/devcontainer.json