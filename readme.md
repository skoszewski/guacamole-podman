# This is a simple Podman setup script for the Apache Guacamole service

The `podman-run.sh` script will initialize a podman pod with required containers to run your own
instance of the [Apache Guacamole](https://guacamole.apache.org/) service.  

This script sets up the `guacd` daemon, postgreSQL database, and guacamole front end.  
Please configure your desired variables in the `guacamole.env` file - more variables can be configured as per the official guacamole documentation.  
You will need to set up your own Reverse Proxy and TLS certificates  

Copy the `guacamole-podman.conf` file to the `/etc/containers/registries.conf.d`
directory to use [docker.io](https://hub.docker.com) container registry.

## Running the pod as a service

Enable session lingering using the `loginctl` command for the current user:

```bash
USER=$(whoami)
sudo loginctl enable-linger $USER
```

Create a pod and containers using the `podman-run.sh` script then stop the pod: `podman-stop.sh`.
Run the `podman-generate-services.sh`.

Now, you can start the pod using:

```bash
systemctl --user start guacamole-guac-pod.service
```

The pod will automatically start after system reboot.

## Updating container images

Stop the pod using the `systemctl --user stop guacamole-guac-pod.service`.

Run `podman-upgrade-images.sh`.

Start the pod: `systemctl --user stop guacamole-guac-pod.service`.

## Help!
If you need any help with getting this running, please raise an issue and I'll do my best to assist
