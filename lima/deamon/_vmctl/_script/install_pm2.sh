#!/bin/zsh
source import_env.sh
# install pm2
limactl shell $VM_NAME sudo npm install pm2 -g
# pm2 version
limactl shell $VM_NAME pm2 --version