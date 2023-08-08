## Overview

Containerfiles and Scripts for Building OpenFlight Containers

## Build Containers

Example container build command:
```bash
podman build --file base/flight-el9-ubi-init.container -t flight-el9-ubi-init
```

In situations where more than just package managers are being used (e.g. `curl`-ing scripts and piping into `/bin/bash`) then it may require handing some sort of network to the build container. The argument `--network=private` should suffice.

