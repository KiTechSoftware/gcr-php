# Core variables
IMAGE=ghcr.io/kitechsoftware/php
BUILDER_IMAGE=$(IMAGE)-builder
DOCKERFILE_DIR=.

# Architectures separately (for manifests)
ARCHS=amd64 arm64

# Define what version is the "latest"
LATEST_VERSION=8.4

# PHP_VERSION must be set
ifndef PHP_VERSION
$(error PHP_VERSION is not set. Usage: make PHP_VERSION=8.3 build)
endif

# Build builder image for all platforms (single-platform builds)
build-builder:
	@for arch in $(ARCHS); do \
		echo "🏗 Building builder for $$arch..."; \
		podman build --pull --rm \
			--arch=$$arch \
			--file $(DOCKERFILE_DIR)/builder/$(PHP_VERSION)/Dockerfile \
			--tag $(BUILDER_IMAGE):$(PHP_VERSION)-$$arch \
			--format docker \
			$(DOCKERFILE_DIR)/builder/$(PHP_VERSION); \
	done

# Build final image for all platforms
build-final: build-builder
	@for arch in $(ARCHS); do \
		echo "🏗 Building final for $$arch..."; \
		podman build --pull --rm \
			--arch=$$arch \
			--file $(DOCKERFILE_DIR)/final/$(PHP_VERSION)/Dockerfile \
			--tag $(IMAGE):$(PHP_VERSION)-$$arch \
			--format docker \
			$(DOCKERFILE_DIR)/final/$(PHP_VERSION); \
	done

manifest-push-builder:
	@echo "📦 Creating manifest for $(PHP_VERSION)..."
	podman push $(BUILDER_IMAGE):$(PHP_VERSION)-amd64
	podman push $(BUILDER_IMAGE):$(PHP_VERSION)-arm64

	podman manifest rm $(BUILDER_IMAGE):$(PHP_VERSION) || true
	podman manifest create $(BUILDER_IMAGE):$(PHP_VERSION)

	@for arch in $(ARCHS); do \
		podman manifest add $(BUILDER_IMAGE):$(PHP_VERSION) docker://$(BUILDER_IMAGE):$(PHP_VERSION)-$$arch; \
	done
	podman manifest push $(BUILDER_IMAGE):$(PHP_VERSION) docker://$(BUILDER_IMAGE):$(PHP_VERSION)

# Create and push multi-arch manifest
manifest-push:
	@echo "📦 Creating manifest for $(PHP_VERSION)..."
	podman push $(IMAGE):$(PHP_VERSION)-amd64
	podman push $(IMAGE):$(PHP_VERSION)-arm64

	podman manifest rm $(IMAGE):$(PHP_VERSION) || true
	podman manifest create $(IMAGE):$(PHP_VERSION)

	@for arch in $(ARCHS); do \
		podman manifest add $(IMAGE):$(PHP_VERSION) docker://$(IMAGE):$(PHP_VERSION)-$$arch; \
	done
	podman manifest push $(IMAGE):$(PHP_VERSION) docker://$(IMAGE):$(PHP_VERSION)

	@if [ "$(PHP_VERSION)" = "$(LATEST_VERSION)" ]; then \
		echo "📦 Creating and pushing manifest for latest..."; \
		podman manifest create $(IMAGE):latest; \
		for arch in $(ARCHS); do \
			podman manifest add $(IMAGE):latest docker://$(IMAGE):$(PHP_VERSION)-$$arch; \
		done; \
		podman manifest push $(IMAGE):latest docker://$(IMAGE):latest; \
	fi

# Build and push
build-push: clean build-final manifest-push

# Build and push
build-push-builder: clean build-builder manifest-push-builder

# Clean images
clean:
	@echo "🧹 Cleaning images for PHP $(PHP_VERSION)..."
	for arch in $(ARCHS); do \
		podman rmi $(IMAGE):$(PHP_VERSION)-$$arch || true; \
		podman rmi $(BUILDER_IMAGE):$(PHP_VERSION)-$$arch || true; \
	done
	podman rmi $(IMAGE):$(PHP_VERSION) || true
	podman rmi $(BUILDER_IMAGE):$(PHP_VERSION) || true
	@if [ "$(PHP_VERSION)" = "$(LATEST_VERSION)" ]; then \
		podman rmi $(IMAGE):latest || true; \
	fi
