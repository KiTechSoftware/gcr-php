IMAGE=ghcr.io/kitechsoftware/php
PHP_VERSION?=8.4
DOCKERFILE_DIR=.

build:
	podman build --pull --rm -f $(DOCKERFILE_DIR)/$(PHP_VERSION)/Dockerfile -t $(IMAGE):$(PHP_VERSION) $(DOCKERFILE_DIR)/$(PHP_VERSION)

run:
	podman run --rm -it -p 9000:9000 $(IMAGE):$(PHP_VERSION)

push:
	podman push $(IMAGE):$(PHP_VERSION)

clean:
	podman rmi $(IMAGE):$(PHP_VERSION) || true
