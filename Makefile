BUILD_NAME       ?= simple
BUILD_TAG        ?= $(shell git rev-parse --short HEAD)

GITHUB_USER_NAME ?= console6500
GITHUB_REPO_NAME ?= github-container-registry-demo
GITHUB_TAG       ?= main

build:
	docker build --progress=plain --tag $(BUILD_NAME):$(BUILD_TAG) .

run: build
	docker run --rm $(BUILD_NAME):$(BUILD_TAG)

test:
	@docker run --rm $(BUILD_NAME):$(BUILD_TAG) \
		| grep 'This is a simple python script called from a container image.' \
		&& echo "TEST PASSED! :D"

github:
	@docker run --rm ghcr.io/$(GITHUB_USER_NAME)/$(GITHUB_REPO_NAME):$(GITHUB_TAG) \
		| grep 'This is a simple python script called from a container image.' \
		&& echo "TEST PASSED! :D"

exec:
	docker exec -it $(BUILD_NAME) bash
