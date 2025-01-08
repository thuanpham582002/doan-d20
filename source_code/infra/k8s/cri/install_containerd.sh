#cd $HOME
#mkdir containerd
#cd containerd
#
#wget https://github.com/containerd/containerd/releases/download/v1.7.22/containerd-1.7.22-linux-arm64.tar.gz
#wget https://github.com/containerd/containerd/releases/download/v1.7.22/containerd-1.7.22-linux-arm64.tar.gz.sha256sum
#echo "Checking the integrity of the downloaded file..."
#sha256sum -c containerd-1.7.22-linux-arm64.tar.gz.sha256sum
#while [ $? -ne 0 ]; do
#  echo "The integrity of the downloaded file is compromised. Downloading the file again..."
#  rm containerd-1.7.22-linux-arm64.tar.gz
#  wget https://github.com/containerd/containerd/releases/download/v1.7.22/containerd-1.7.22-linux-arm64.tar.gz
#  sha256sum -c containerd-1.7.22-linux-arm64.tar.gz.sha256sum
#done
#tar -xvf containerd-1.7.22-linux-arm64.tar.gz
#sudo cp bin/* /usr/local/bin/
#
#cd ..
#rm -rf containerd
#
#mkdir containerd_service
#cd containerd_service
#wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
#sudo cp containerd.service /etc/systemd/system/
#
#sudo systemctl daemon-reload
#sudo systemctl enable --now containerd
#cd ..
#rm -rf containerd_service
#
#
#mkdir runc
#cd runc
#wget https://github.com/opencontainers/runc/releases/download/v1.1.15/runc.arm64
#install -m 755 runc.arm64 /usr/local/sbin/runc
#cd ..
#rm -rf runc
#
#mkdir cni_plugins
#cd cni_plugins
#wget https://github.com/containernetworking/plugins/releases/download/v1.5.1/cni-plugins-linux-arm64-v1.5.1.tgz
#mkdir -p /opt/cni/bin
#sudo tar -xzvf cni-plugins-linux-arm64-v1.5.1.tgz -C /opt/cni/bin
#rm cni-plugins-linux-arm64-v1.5.1.tgz
#cd ..
#rm -rf cni_plugins
#
#
## Configuring the systemd cgroup driver
#sudo mkdir -p /etc/containerd/
#sudo containerd config default | sudo tee /etc/containerd/config.toml
#sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
#sudo sed -i 's|registry.k8s.io/pause:3.8|registry.k8s.io/pause:3.2|' /etc/containerd/config.toml
#sudo systemctl restart containerd
#

set -eux -o pipefail
grep SystemdCgroup /etc/containerd/config.toml && exit 0
grep "version = 2" /etc/containerd/config.toml || exit 1
# Configuring the systemd cgroup driver
# Overriding the sandbox (pause) image
cat <<EOF >>/etc/containerd/config.toml
  [plugins]
    [plugins."io.containerd.grpc.v1.cri"]
      sandbox_image = "$(kubeadm config images list | grep pause | sort -r | head -n1)"
      [plugins."io.containerd.grpc.v1.cri".containerd]
        [plugins."io.containerd.grpc.v1.cri".containerd.runtimes]
          [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
            runtime_type = "io.containerd.runc.v2"
            [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
              SystemdCgroup = true
EOF
systemctl restart containerd