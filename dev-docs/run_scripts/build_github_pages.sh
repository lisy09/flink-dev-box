#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
TARGET_DOCS_DIR=${ROOT_DIR}/../docs

set -x

instance=$(docker run -d --rm \
    -t ${BASE_IMAGE_FULL} \
    /bin/sh -c "while :; do sleep 10; done")

docker cp ${ROOT_DIR}/${DOCS_RELATIVE_PATH} $instance:${WOKRKING_PACKAGE_PATH}/${DOCS_RELATIVE_PATH}

docker exec $instance bash -c "cd ${WOKRKING_PACKAGE_PATH} \
    && DOCS_BASEURL=/dev-docs-template/ npx vuepress build ${DOCS_RELATIVE_PATH}"

rm -rf ${TARGET_DOCS_DIR}
docker cp $instance:${WOKRKING_PACKAGE_PATH}/${DOCS_RELATIVE_PATH}/.vuepress/dist ${TARGET_DOCS_DIR}

docker stop $instance