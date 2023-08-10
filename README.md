## Overview

Containerfiles and Scripts for Building OpenFlight Containers

## What Images are Here?

- `base`: An service container base image with the OpenFlight repos enabled
- `cluster-inventory`: A service container running the Flight Hunter inventory server
- `admin-ssh`: A service container sharing an SSH public key and providing initial admin access to client nodes

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

Download the `freight` helper script (for downloading, running and using these service containers):
```bash
wget -O /usr/local/bin/freight https://raw.githubusercontent.com/openflighthpc/openflight-containers/main/bin/freight
chmod +x /usr/local/bin/freight
```

### Get Container Image

```bash
freight download SERVICE_NAME
```

### Launch Containers

```bash
freight launch SERVICE_NAME
```
