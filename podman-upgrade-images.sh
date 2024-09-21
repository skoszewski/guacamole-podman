#!/bin/bash

# Pull updated images
podman image ls -n | awk '{ print $1":"$2 }' | xargs -n1 podman pull

# Remove obsolete images
podman image ls -n | awk '/^<none>/ { print $3 }' | xargs -n1 podman rmi
