#!/bin/zsh
source import_env.sh
echo "Installing jfrog registry server"
limactl shell $VM_NAME sudo mkdir -p /tools/jfrog/data
limactl shell $VM_NAME sudo chown -R 1030:1030 /tools/jfrog/data
limactl shell $VM_NAME sudo docker run --name artifactory-jfrog --restart unless-stopped -v /tools/jfrog/data/:/var/opt/jfrog/artifactory -d -p 8081:8081 -p 8082:8082 releases-docker.jfrog.io/jfrog/artifactory-oss:7.77.5