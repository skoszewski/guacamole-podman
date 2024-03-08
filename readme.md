# This is a simple Podman setup script for the Apache Guacamole service

This script will initialize a podman pod with required containers to run your own
instance of the [Apache Guacamole](https://guacamole.apache.org/) service.  

This script sets up the `guacd` daemon, postgreSQL database, and guacamole front end.  
Please configure your desired variables in the `guacamole.env` file - more variables can be configured as per the official guacamole documentation.  
You will need to set up your own Reverse Proxy and TLS certificates  

Copy the `guacamole-podman.conf` file to the `/etc/containers/registries.conf.d`
directory to use [docker.io](https://hub.docker.com) container registry.

## Help!
If you need any help with getting this running, please raise an issue and I'll do my best to assist
