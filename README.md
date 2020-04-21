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

  * Preperation
  ```bash
   sudo curl  https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo
   sudo yum makecache
   sudo dnf -y install docker-ce --nobest
   sudo dnf -y install  git
   sudo systemctl enable --now docker
   sudo curl -L https://github.com/docker/compose/releases/download/1.7.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose && ln -sv /usr/local/bin/docker-compose /usr/bin/docker-compose
   sudo docker-compose --version
   sudo docker --version
  
  ```
  
  * [Edit docker-compose.sh file](https://raw.githubusercontent.com/jaganthoutam/adop-docker-compose-latest/master/docker-compose.sh)


```bash
export CUSTOM_NETWORK_NAME=swarm_attachable
docker network create $CUSTOM_NETWORK_NAME
export DOCKER_NETWORK_SUBNET_CIDR="172.18.0.0/16"      # Docker Net, this is to allow git lab to do health checks
export INITIAL_ADMIN_PASSWORD_PLAIN=test1234           # Initial Admin password 
export INITIAL_ADMIN_USER=adopadmin
export PUBLIC_IP=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1) # Should be ur Publip IP, If internal use Local ip
export TARGET_HOST=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1) # Internal IP
export IP=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1)  # Internal IP

source credentials.generate.sh      # Generate platform Secrets
source platform.secrets.sh          # Source platform secrets
source env.config.sh                # source env configs
```
