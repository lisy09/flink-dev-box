ifneq (,$(wildcard ./.env))
    include .env
    export
endif

SCRIPT_DIR = ./scripts


# create a new flink scala project
.PHONY: new
new: new-scala

.PHONY: new-scala
new-scala:
	bash ${SCRIPT_DIR}/new_flink_scala_project.sh

.PHONY: new-java
new-java: new-java-maven

.PHONY: new-java-maven
new-java-maven:
	bash ${SCRIPT_DIR}/new_flink_java_maven_project.sh

.PHONY: jar-local
jar-local:
	bash ${SCRIPT_DIR}/build_jar_local.sh

.PHONY: jar
jar:
	bash ${SCRIPT_DIR}/build_jar.sh

.PHONY: deploy
deploy:
	bash ${SCRIPT_DIR}/deploy.sh
.PHONY: undeploy
undeploy:
	bash ${SCRIPT_DIR}/undeploy.sh
.PHONY: check-hdfs
check-hdfs:
	bash ${SCRIPT_DIR}/check_hdfs.sh
