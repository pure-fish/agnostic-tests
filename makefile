#!/usr/bin/make -sf
SHELL := /usr/bin/env bash

IMPLEMENTATION ?= fish
FISH_PURE_DIR ?= $(CURDIR)/.implementations/pure-fish
PYTHON_PURE_DIR ?= $(CURDIR)/.implementations/pure.py
GO_PURE_DIR ?= $(CURDIR)/.implementations/pure.go
GO_PURE_BIN ?= $(GO_PURE_DIR)/pure

export IMPLEMENTATION FISH_PURE_DIR PYTHON_PURE_DIR GO_PURE_BIN

.PHONY: default
default: usage
usage:
	@printf "usage:\n"
	@printf "\tmake checkout\t\t\t\t# clone the three implementations\n"
	@printf "\tmake test IMPLEMENTATION=go\t\t# run the suite on one implementation\n"
	@printf "\tmake test-all\t\t\t\t# run the suite on every implementation\n"
	@printf "\tmake docker-test IMPLEMENTATION=go\t# same, inside the Docker image\n"

.PHONY: checkout
checkout:
	mkdir -p .implementations
	test -d $(FISH_PURE_DIR) || git clone --depth 1 https://github.com/pure-fish/pure $(FISH_PURE_DIR)
	test -d $(PYTHON_PURE_DIR) || git clone --depth 1 https://github.com/edouard-lopez/pure.py $(PYTHON_PURE_DIR)
	test -d $(GO_PURE_DIR) || git clone --depth 1 https://github.com/edouard-lopez/pure.go $(GO_PURE_DIR)

.PHONY: build-go
build-go:
	cd $(GO_PURE_DIR) && go build -o $(GO_PURE_BIN) ./cmd

.PHONY: test
test: $(if $(filter go,$(IMPLEMENTATION)),build-go)
	bats --timing specs/

.PHONY: test-all
test-all: build-go
	failed=0; \
	for implementation in fish python go; do \
		echo "== $$implementation"; \
		IMPLEMENTATION=$$implementation bats specs/ || failed=1; \
	done; \
	exit $$failed

.PHONY: docker-test
docker-test:
	docker build --file docker/Dockerfile --tag pure-agnostic-tests .
	docker run --rm --env IMPLEMENTATION=$(IMPLEMENTATION) pure-agnostic-tests
