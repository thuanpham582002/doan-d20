#!/bin/bash
# See <https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/>
set -eux -o pipefail
command -v kubeadm >/dev/null 2>&1 && exit 0
# Install and configure prerequisites
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sysctl --system
# Installing kubeadm, kubelet and kubectl
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y apt-transport-https ca-certificates curl
VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt | sed -e 's/v//' | cut -d'.' -f1-2)
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v${VERSION}/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v${VERSION}/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
apt-get update
# cri-tools
apt-get install -y cri-tools
# cni-plugins
apt-get install -y kubernetes-cni
rm -f /etc/cni/net.d/*.conf*
apt-get install -y kubelet kubeadm kubectl && apt-mark hold kubelet kubeadm kubectl
systemctl enable --now kubelet