#!/bin/zsh
source import_env.sh
limactl shell $VM_NAME sudo curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
limactl shell $VM_NAME sudo bash nodesource_setup.sh
limactl shell $VM_NAME sudo rm nodesource_setup.sh
limactl shell $VM_NAME sudo apt install nodejs
echo "limactl shell $VM_NAME sudo node --version"
limactl shell $VM_NAME sudo node --version