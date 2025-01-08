cd $HOME
VERSION=v4.2.0
BINARY=yq_linux_arm64
if ! command -v yq &> /dev/null; then
  echo "yq is not installed. Trying to install yq..."
  sudo cp /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/resource/yq_linux_arm64 /usr/bin/yq

  if [ $? -eq 0 ]; then
    echo "yq is installed successfully."
  else
    echo "Failed to install yq."
    exit 1
  fi

  # Clean up
  rm -rf ${BINARY}.tar.gz˘.
fi

sudo yq e '
del(.network.ethernets.lima0.match) |
del(.network.ethernets.lima0.set-name) |
.network.ethernets.lima0.dhcp4 = false |
.network.ethernets.lima0.addresses = ["'$STATIC_IP'/24"] |
.network.ethernets.lima0.routes[0].to = "0.0.0.0/0" |
.network.ethernets.lima0.routes[0].via = "192.168.105.1"
' /etc/netplan/50-cloud-init.yaml -i

# Apply the changes
sudo netplan apply

echo "Static IP is configured successfully."