#!/bin/bash
dataexists=1
if [[ ! -d "./data" ]]
then
    echo Creating data directory.
    mkdir ./data
    dataexists=0
fi
if [[ ! -d "./config" ]]
then
    mkdir ./config
    touch ./config/guacamole.properties
fi

podman pod create \
	--name guac-pod \
	-p 8020:8080 

podman run --name guacd \
	--pod guac-pod \
	-d \
	guacamole/guacd

podman run --name guac-postgres \
	--pod guac-pod \
	-d \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-e POSTGRES_PASSWORD=guacamole \
        -v ./data:/var/lib/postgresql/data \
	postgres:14

if [ $dataexists -eq 0 ]
then
	echo Waiting for postgres to start
	sleep 30
	echo Creating starter database
	podman run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgresql > initdb.sql
	podman exec -i guac-postgres sh -c 'psql -U postgres' < initdb.sql
else
	echo DB Already exists
fi
	
podman run --name guacamole \
	--pod guac-pod \
	-v ./config:/config \
	--env-file ./guacamole.env \
	-e POSTGRES_HOSTNAME=127.0.0.1 \
	-e POSTGRES_PASSWORD=guacamole \
	-d \
	guacamole/guacamole
