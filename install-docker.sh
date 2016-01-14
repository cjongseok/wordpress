#!/bin/bash
# It is only tested on Ubuntu 14.04 on AWS

isRoot () {
	if [ "$EUID" -ne 0 ]; then
		return 0
	fi
	return 1
}

runAsRoot () {
    isRoot

    if [ $? -eq 0 ]; then
        echo "run as root"
        exit
    fi
}

runAsRoot

# Add a repository to apt
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get purge -y lxc-docker
sudo apt-cache policy docker-engine

# Install linux-image-extra
sudo apt-get update
sudo apt-get install -y linux-image-extra-$(uname -r)

# Install Docker
sudo apt-get update
sudo apt-get install -y docker-engine

# Install pip
sudo apt-get install -y python-pip
sudo pip install docker-compose

# Create directories for container persistence
DOCKER_PERSISTENCE=/opt/docker-persistence
MARIA_PERSISTENCE=$DOCKER_PERSISTENCE/mariadb
WP_PERSISTENCE=$DOCKER_PERSISTENCE/wordpress

sudo mkdir -p $MARIA_PERSISTENCE/data
sudo mkdir -p $MARIA_PERSISTENCE/conf.d
sudo mkdir -p $WP_PERSISTENCE






