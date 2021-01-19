#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
FLINK_VERSION=${FLINK_VERSION:-1.12.1}

set -ex

mvn archetype:generate                               \
    -DarchetypeGroupId=org.apache.flink              \
    -DarchetypeArtifactId=flink-quickstart-java      \
    -DarchetypeVersion=${FLINK_VERSION}

POM_FILEPATH=$(find . | grep pom.xml)
NEW_PROJECT_DIR=$(dirname "${POM_FILEPATH}")

mv $POM_FILEPATH $ROOT_DIR
mv ${NEW_PROJECT_DIR}/src $ROOT_DIR

rm -rf ${NEW_PROJECT_DIR}

xmlstarlet ed --inplace -u "//*/groupId[text()='org.apache.flink']/../scope" -v "compile" ${ROOT_DIR}/pom.xml
#!/bin/bash

PARENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ROOT_DIR="$( cd $PARENT_DIR/.. >/dev/null 2>&1 && pwd )"
FLINK_VERSION=${FLINK_VERSION:-1.12.1}

set -ex

mvn archetype:generate                               \
    -DarchetypeGroupId=org.apache.flink              \
    -DarchetypeArtifactId=flink-quickstart-java      \
    -DarchetypeVersion=${FLINK_VERSION}

POM_FILEPATH=$(find . | grep pom.xml)
NEW_PROJECT_DIR=$(dirname "${POM_FILEPATH}")

mv $POM_FILEPATH $ROOT_DIR
mv ${NEW_PROJECT_DIR}/src $ROOT_DIR

rm -rf ${NEW_PROJECT_DIR}

xmlstarlet ed --inplace -N ns="http://maven.apache.org/POM/4.0.0" \
    -u "//*/ns:dependency[ns:groupId='org.apache.flink']/ns:scope" -v "compile" ${ROOT_DIR}/pom.xml

xmlstarlet ed --inplace -N ns="http://maven.apache.org/POM/4.0.0" \
    -d "//*/ns:plugin[ns:groupId='org.eclipse.m2e']" ${ROOT_DIR}/pom.xml
