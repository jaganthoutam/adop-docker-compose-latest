[![Build Status](https://travis-ci.org/Accenture/adop-docker-compose.svg?branch=master)](https://travis-ci.org/Accenture/adop-docker-compose)
[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/Accenture/ADOP)

   * Firewalld Rules
```bash
systemctl restart firewalld
systemctl enable firewalld
firewall-cmd --zone=public --add-port=80/tcp --permanent  
firewall-cmd --zone=public  --add-port=443/tcp --permanent  
firewall-cmd --zone=public --add-port=6443/tcp --permanent
firewall-cmd --zone=public --add-port=2376/tcp --permanent
firewall-cmd --zone=public --add-port=2377/tcp --permanent
firewall-cmd --zone=public --add-port=2379/tcp --permanent
firewall-cmd --zone=public --add-port=2380/tcp --permanent
firewall-cmd --zone=public --add-port=4789/udp --permanent
firewall-cmd --zone=public --add-port=7946/tcp --permanent
firewall-cmd --zone=public --add-port=7946/udp --permanent
firewall-cmd --zone=public --add-port=10250/tcp --permanent
firewall-cmd --zone=public --add-port=8000-8001/tcp --permanent
firewall-cmd --zone=public --add-port=8443-8444/tcp --permanent
firewall-cmd --zone=public --add-port=1337/tcp --permanent
firewall-cmd --zone=public --add-port=27017/tcp --permanent
firewall-cmd --zone=public --add-masquerade --permanent
firewall-cmd --permanent --zone=public --change-interface=docker0
firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 4 -i docker0 -j ACCEPT
firewall-cmd --reload
systemctl restart firewalld
systemctl restart docker
```


# The DevOps Platform: Overview

  Componenets connected
  
    * Jenkins
    * Jenkins swarm slave, 
    * Sonar
    * Nexus 
    * selenium 
    * LDAP

# Quickstart Instructions

  * Preparation
  ```bash
   systemctl stop firewalld
   systemctl disable firewalld
   systemctl status firewalld
   sed -i s/^SELINUX=.*$/SELINUX=permissive/ /etc/selinux/config
   setenforce 0
   yum update -y
   yum install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
   sudo curl  https://download.docker.com/linux/centos/docker-ce.repo -o /etc/yum.repos.d/docker-ce.repo
   sudo yum makecache
   sudo dnf -y install docker-ce
   sudo dnf -y install  git
   sudo systemctl enable --now docker
   sudo curl -L https://github.com/docker/compose/releases/download/1.25.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose && ln -sv /usr/local/bin/docker-compose /usr/bin/docker-compose
   sudo docker-compose --version
   sudo docker --version
  
  ```
  
  # Deployment
  ```bash
  git clone https://github.com/jaganthoutam/adop-docker-compose-latest.git
  cd adop-docker-compose-latest
  ```
  * [Edit docker-compose.sh file](https://raw.githubusercontent.com/jaganthoutam/adop-docker-compose-latest/master/docker-compose.sh)


```bash
export CUSTOM_NETWORK_NAME=swarm_attachable
docker network create $CUSTOM_NETWORK_NAME
export DOCKER_NETWORK_SUBNET_CIDR="172.18.0.0/16"      # Docker Net, this is to allow git lab to do health checks
export DOCKER_NETWORK_GW=$(docker network inspect $CUSTOM_NETWORK_NAME | grep Gateway | awk '{print $2}' | sed -e 's/^"//' -e 's/"//') 
export INITIAL_ADMIN_PASSWORD_PLAIN=CHANGEME           # Initial Admin password  
export INITIAL_ADMIN_USER=adopadmin
export PUBLIC_IP=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1) # Should be ur Publip IP, If internal use Local ip
export TARGET_HOST=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1) # Internal IP
export IP=$(/sbin/ip -o -4 addr list ens4 | awk '{print $4}' | cut -d/ -f1)  # Internal IP

source credentials.generate.sh      # Generate platform Secrets
source platform.secrets.sh          # Source platform secrets
source env.config.sh                # source env configs
```
# docker-compose up 
```bash
chmod + docker-compose.sh
./docker-compose.sh



OUTPUT:
./docker-compose.sh
Script Name: ./docker-compose.sh
Error response from daemon: network with name swarm_attachable already exists
Your secrets file already exists, will not re-create...
Sourcing variables from platform.secrets.sh file...
The version of your secrets file is up to date, moving on...
ldap-phpadmin is up-to-date
selenium-node-firefox is up-to-date
selenium-node-chrome is up-to-date
ldap is up-to-date
jenkins is up-to-date
filebeat is up-to-date
gitlab-redis is up-to-date
gitlab-postgresql is up-to-date
ldap-ltb is up-to-date
sonar is up-to-date
sonar-mysql is up-to-date
proxy is up-to-date
jenkins-slave is up-to-date
nexus is up-to-date
selenium-hub is up-to-date
gitlab is up-to-date
```
#Check Docker-compose status

```bash
docker-compose ps

        Name                       Command                  State                                Ports
--------------------------------------------------------------------------------------------------------------------------------
filebeat                /usr/local/bin/docker-entr ...   Up
gitlab                  /assets/wrapper                  Up (healthy)   22/tcp, 443/tcp, 80/tcp
gitlab-postgresql       docker-entrypoint.sh postgres    Up             5432/tcp
gitlab-redis            docker-entrypoint.sh redis ...   Up             6379/tcp
jenkins                 /entrypoint.sh                   Up             0.0.0.0:50000->50000/tcp, 8080/tcp
jenkins-slave           /bin/sh -c java -jar /bin/ ...   Up
ldap                    /usr/local/bin/entrypoint. ...   Up             0.0.0.0:389->389/tcp
ldap-ltb                /etc/service/apache2/run         Up             80/tcp
ldap-phpadmin           /run.sh                          Up             80/tcp
nexus                   /usr/local/bin/nexus.sh          Up             0.0.0.0:5000->5000/tcp, 0.0.0.0:5001->5001/tcp, 8081/tcp
proxy                   /resources/scripts/entrypo ...   Up             0.0.0.0:443->443/tcp, 0.0.0.0:80->80/tcp
selenium-hub            /opt/bin/entry_point.sh          Up             4444/tcp
selenium-node-chrome    /opt/bin/entry_point.sh          Up
selenium-node-firefox   /opt/bin/entry_point.sh          Up
sonar                   /usr/local/bin/sonar.sh          Up             9000/tcp
sonar-mysql             /entrypoint.sh mysqld            Up             3306/tcp

```



