ifneq (,$(wildcard ./.env))
    include .env
    export
endif

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
# CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
CURRENT_DIR :=  $(patsubst %/,%,$(dir $(mkfile_path)))

BUILD_SCRIPTS_PATH = ./build_scripts
RUN_SCRIPTS_PATH = ./run_scripts

.PHONY: all
all: base  

.PHONY: base
base:
	bash $(BUILD_SCRIPTS_PATH)/build_base.sh

.PHONY: push
push:
	bash $(BUILD_SCRIPTS_PATH)/push_docker_images.sh

.PHONY: delete-images
delete-images:
	bash $(BUILD_SCRIPTS_PATH)/delete_local_images.sh

.PHONY: run-app-cluster
run-app-cluster:
	echo ${CURRENT_DIR}
	# docker-compose -f ${current_dir}/application_cluster.yaml up -d 

.PHONY: stop-app-cluster
stop-app-cluster:
	docker-compose -f application_cluster.yaml down 

.PHONY: run-session-cluster
run-session-cluster:
	docker-compose -f session_cluster.yaml up -d 

.PHONY: stop-session-cluster
stop-session-cluster:
	docker-compose -f session_cluster.yaml down 

.PHONY: deploy
deploy: deploy-hadoop-bundle-flink

.PHONY: undeploy
undeploy: undeploy-hadoop-bundle-flink

SCALE_TASKMANAGER ?= 1
.PHONY: deploy-hadoop-bundle-flink
deploy-hadoop-bundle-flink:
ifeq (,$(shell docker network ls -f name=app -q))
	@docker network create app
endif
	docker-compose --env-file .env -f flink_hadoop.yaml up -d --scale taskmanager=$(SCALE_TASKMANAGER)

.PHONY: undeploy-hadoop-bundle-flink
undeploy-hadoop-bundle-flink:
	docker-compose --env-file .env -f flink_hadoop.yaml down