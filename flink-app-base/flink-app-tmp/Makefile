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
