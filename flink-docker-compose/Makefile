ifneq (,$(wildcard ./.env))
    include .env
    export
endif

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
# CURRENT_DIR := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
CURRENT_DIR :=  $(patsubst %/,%,$(dir $(mkfile_path)))

BUILD_SCRIPTS_PATH = ./build_scripts
RUN_SCRIPTS_PATH = ./run_scripts

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