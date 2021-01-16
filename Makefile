ifneq (,$(wildcard ./.env))
    include .env
    export
endif

BUILD_SCRIPTS_PATH = ./build_scripts
RUN_SCRIPTS_PATH = ./run_scripts

# docs
DOCS_DIR = ./dev-docs
.PHONY: github-pages
github-pages:
	cd ${DOCS_DIR} && make github-pages
.PHONY: docs-preview
docs-preview:
	cd ${DOCS_DIR} && make preview
.PHONY: docs-stop-preview
docs-stop-preview:
	cd ${DOCS_DIR} && make stop-preview