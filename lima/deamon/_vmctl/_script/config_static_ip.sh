cd $HOME
VERSION=v4.2.0
BINARY=yq_linux_arm64
if ! command -v yq &> /dev/null; then
  echo "yq is not installed. Trying to install yq..."
  wget https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY}.tar.gz -O - |\
  tar xz && sudo mv ${BINARY} /usr/bin/yq

  if [ $? -eq 0 ]; then
    echo "yq is installed successfully."
  else
    echo "Failed to install yq."
    exit 1
  fi

  # Clean up
  rm -rf ${BINARY}.tar.gz
fi

sudo yq e '
.network.ethernets.lima0.dhcp4 = false |
.network.ethernets.lima0.addresses = ["'$STATIC_IP'/24"] |
.network.ethernets.lima0.routes[0].to = "0.0.0.0/0" |
.network.ethernets.lima0.routes[0].via = "192.168.105.1"
' /etc/netplan/50-cloud-init.yaml -i

# Apply the changes
sudo netplan apply