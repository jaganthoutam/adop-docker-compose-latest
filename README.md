[![Build Status](https://travis-ci.org/Accenture/adop-docker-compose.svg?branch=master)](https://travis-ci.org/Accenture/adop-docker-compose)
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Accenture/ADOP)

# The DevOps Platform: Overview

  Componenets connected
  
    * Jenkins
    * Jenkins swarm slave, 
    * Sonar
    * Nexus 
    * selenium 
    * LDAP

# Quickstart Instructions
  
  https://raw.githubusercontent.com/jaganthoutam/adop-docker-compose-latest/master/docker-compose.sh

  sh ``
 export CUSTOM_NETWORK_NAME=swarm_attachable
docker network create $CUSTOM_NETWORK_NAME
export DOCKER_NETWORK_SUBNET_CIDR="172.18.0.0/16"      # Docker Net, this is to allow git lab to do health checks
export INITIAL_ADMIN_PASSWORD_PLAIN=test1234           # Initial Admin password 
export INITIAL_ADMIN_USER=adopadmin
export PUBLIC_IP=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1)
export TARGET_HOST=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1)
export IP=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1)

source credentials.generate.sh
source platform.secrets.sh
source env.config.sh
`` sh
