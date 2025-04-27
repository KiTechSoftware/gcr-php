# PHP Image

## Supported Versions
- PHP 8.3
- PHP 8.4 (also tagged as `latest`)

## Supported Base Images
- Debian Bookworm Slim

## Deprecated
- Alpine-based images
- CLI-based images

## Development & Testing

For easier local builds and testing, the repository now includes both a **Taskfile** and a **Makefile**.

### Using Taskfile
Install [Task](https://taskfile.dev/#/installation) if you haven't already, then:

```bash
# Build the image (defaults to PHP 8.4)
task build

# Run the image locally (exposes port 9000)
task run

# Push the image manually
task push

# Clean local built images
task clean

# Specify a different PHP version (8.3 for example)
PHP_VERSION=8.3 task build
```

### Using Makefile
Alternatively, you can use `make`:

```bash
# Build the image
make build

# Run the image locally
make run

# Push the image manually
make push

# Clean the local built image
make clean

# Specify a different PHP version
make build PHP_VERSION=8.3
```

---

## Notes

The PHP image now exclusively supports **Debian Bookworm Slim**.  
Alpine and CLI variants are no longer maintained.  

If you're transitioning from previous versions, ensure compatibility with the latest Debian-based setup.

The `8.4` version is also tagged as `latest`, meaning you can pull either `:8.4` or `:latest` interchangeably.

> This repository builds and publishes multi-architecture images (`linux/amd64`, `linux/arm64`) using GitHub Actions and Docker Buildx.

---
