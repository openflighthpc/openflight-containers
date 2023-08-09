## Overview

Containerfiles and Scripts for Building OpenFlight Containers

## Build Containers

Example container build command:
```bash
podman build --squash --no-cache --network=host --file IMAGE_NAME/IMAGE_NAME.container -t flight-IMAGE_NAME
```

Where:
- `--squash` ensures a single layer exists as the output (should make moving container around a lot easier) 
- `--no-cache` ensures a full build is run regardless of any existing cache of layers/files
- `--network=host` piggybacks on the host network for any network calls (this seems to provide best performance and less failures when doing g things like `bundle install`) 
- `--file` is the input containerfile
- `-t` is the name of the built image

## Distribute Containers

The simplest way to distribute container images in a manner which doesn't require internet connection is to export them to a file. 

To build a tar file of the image:
```bash
podman save -o IMAGE_NAME-container.tar IMAGE_NAME
```

## Use Containers

### Prepare Host

The container needs to have some sort of container service to run containers here. 

In EL9, this can be setup with:
```bash
dnf install container-tools
```

In EL8, this can be setup with:
```bash
dnf module install container-tools
```

### Get Container Image

- Download/copy the image tarfile created earlier to the host
- Import image
  ```bash
  podman load -o IMAGE_NAME-container.tar IMAGE_NAME
  ```

### Launch Containers

```bash
podman run -d --network=host --name=CONTAINER_NAME IMAGE_NAME
```
