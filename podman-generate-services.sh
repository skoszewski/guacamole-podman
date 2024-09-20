#!/bin/bash

# Generate service files
podman generate systemd guac-pod --files --name --pod-prefix guacamole --container-prefix guacamole --no-header

# Copy service files to the systemd user's folder
cp -a *.service $HOME/.config/systemd/user

# Enable services
systemctl --user daemon-reload
systemctl --user list-unit-files | awk '/^guacamole/ { print $1 }' | xargs -r systemctl --user enable

# Remove service files from the current directory
rm -f *.service
