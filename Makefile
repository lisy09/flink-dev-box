ifneq (,$(wildcard ./.env))
    include .env
    export
endif

BUILD_SCRIPTS_PATH = ./build_scripts
RUN_SCRIPTS_PATH = ./run_scripts

.PHONY: run-app-cluster
run-app-cluster:
	docker-compose -f docker-compose/application_cluster.yaml up -d 

.PHONY: stop-app-cluster
stop-app-cluster:
	docker-compose -f docker-compose/application_cluster.yaml down 

.PHONY: run-session-cluster
run-session-cluster:
	docker-compose -f docker-compose/session_cluster.yaml up -d 

.PHONY: stop-session-cluster
stop-session-cluster:
	docker-compose -f docker-compose/session_cluster.yaml down 