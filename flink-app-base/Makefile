ifneq (,$(wildcard ./.env))
    include .env
    export
endif

BUILD_SCRIPTS_PATH = ./build_scripts

.PHONY: all
all: base  

.PHONY: base
base:
	bash $(BUILD_SCRIPTS_PATH)/build_base.sh

.PHONY: push
push:
	bash $(BUILD_SCRIPTS_PATH)/push_docker_images.sh

.PHONY: clear
clear:
	bash $(BUILD_SCRIPTS_PATH)/clear.sh

.PHONY: delete-images
delete-images:
	bash $(BUILD_SCRIPTS_PATH)/delete_local_images.sh

.PHONY: new
new:
	bash $(BUILD_SCRIPTS_PATH)/create_new_project.sh

# .PHONY: run-base
# run-base:
# 	$(BUILD_SCRIPTS_PATH)/run_scala_base.sh

# .PHONY: sbt-run
# sbt-run:
# 	sbt "run conf/app.conf"

# .PHONY: sbt-assembly
# sbt-assembly:
# 	sbt clean assembly

# .PHONY: jar
# jar:
# 	${BUILD_SCRIPTS_PATH}/build_jar.sh