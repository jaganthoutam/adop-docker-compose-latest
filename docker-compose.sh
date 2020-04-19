#!/bin/bash

echo Script Name: "$0"

export CUSTOM_NETWORK_NAME=swarm_attachable
docker network create $CUSTOM_NETWORK_NAME
export DOCKER_NETWORK_SUBNET_CIDR="172.18.0.0/16"
export INITIAL_ADMIN_PASSWORD_PLAIN=test1234
export INITIAL_ADMIN_USER=adopadmin
export PUBLIC_IP=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1)
export TARGET_HOST=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1)
export IP=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1)

source credentials.generate.sh
source platform.secrets.sh
source env.config.sh
if [ "$1" = down ]
then
        docker-compose -f docker-compose.yml -f etc/volumes/local/default.yml down
	docker volume rm $(docker volume ls | awk '{print $2}')
else 

docker-compose -f docker-compose.yml -f etc/volumes/local/default.yml up -d

fi
